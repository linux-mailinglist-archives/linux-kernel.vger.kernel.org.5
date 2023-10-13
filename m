Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D77C8374
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjJMKn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJMKnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:43:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F3FD7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:43:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11518C433CA;
        Fri, 13 Oct 2023 10:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697193830;
        bh=45SmktxflpqPYwlKo6pzUpVsREOXFrpnKqeP0QuQW4s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VRlj8SmlTRJAmHtNaXkBhlduM8TwsgX9Qmbvb3B7+VF+1Tr0RUN6r68YCsLgE356t
         1xpXkanwmHTBrFEDedeMhs4awOhMc/lqvrg6dFU1SUCu3D+0CrV1AgfZk5NFnoogP4
         PpKCWN4FY0WgFwOkoFdx8VZQbo18g/X+wAuZn8C7ACVTmIeZQZjZtbh25YXsI+fsNP
         lvfvg4I3zJr5eX58jmYR31JnxormeL5+hx2jZHXYJMOUtkA8DtQHJMvM1FtuTdqB/E
         dYsRHAju/7HYxycvdCpRs6wk7ZqQNNgmz2CesWWJ6nHohOGh28/YeFPxiSydS8KBPj
         FFWF4x5mIm1hg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
In-Reply-To: <20231009172923.2457844-15-robh@kernel.org>
References: <20231009172923.2457844-15-robh@kernel.org>
Subject: Re: [PATCH] phy: Use device_get_match_data()
Message-Id: <169719382764.165658.18062385265662490289.b4-ty@kernel.org>
Date:   Fri, 13 Oct 2023 16:13:47 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 09 Oct 2023 12:29:10 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> 

Applied, thanks!

[1/1] phy: Use device_get_match_data()
      commit: 21bf6fc47a1e45031ba8a7084343b7cfd09ed1d3

Best regards,
-- 
~Vinod



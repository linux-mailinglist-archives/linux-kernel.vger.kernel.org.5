Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBE67C8379
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjJMKoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjJMKny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:43:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B0FD6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:43:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2527C433C9;
        Fri, 13 Oct 2023 10:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697193832;
        bh=3lYFs6bchwNMSq1INqyRMVNErXqm99CbpOPb/MT7JX4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mmiwaVRcMxZX7I6GjOlW+9Bq0wm/YT3US0tBClbf+V4BSkHMxMFUNuufOJRGhm87b
         oSip0mXlaXuKZVOpfWLKX2ncz5jAp5RQ8mkF2PGBS6t1DGuAGUWh5pxB2y/J6k/CO5
         BBVaaV8gRSYaWRCnljjnUkS4O1U+B3RFngdPyx6JlTGOupSO+G0VrthtDhmA196uWQ
         O29gM5qcE8tP7DA43dxt2y/sUb3FEbWM10Zt2gBKRW4aWdvVmnfGeBQewZq6h1Mut6
         ECoVzXBFpkZSb7nQO0gT2P6dnJgCYzfKY58FjuOwW91+mbRStJ1Zgee0NxDugiHfOR
         4j9zG1yJ5Yldw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231009172923.2457844-17-robh@kernel.org>
References: <20231009172923.2457844-17-robh@kernel.org>
Subject: Re: [PATCH] phy: rockchip-inno-usb2: Drop unnecessary DT includes
Message-Id: <169719383030.165658.14179567430035290525.b4-ty@kernel.org>
Date:   Fri, 13 Oct 2023 16:13:50 +0530
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


On Mon, 09 Oct 2023 12:29:12 -0500, Rob Herring wrote:
> Neither of_address.h or of_platform.h are used in the driver, so drop them.
> 
> 

Applied, thanks!

[1/1] phy: rockchip-inno-usb2: Drop unnecessary DT includes
      commit: 8b6fba3e79eb67411d2a0a70955e41abc7007210

Best regards,
-- 
~Vinod



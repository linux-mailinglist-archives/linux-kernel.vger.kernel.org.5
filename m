Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97E079A38B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjIKGdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjIKGdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:33:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DACEA;
        Sun, 10 Sep 2023 23:33:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E429C433C7;
        Mon, 11 Sep 2023 06:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694413986;
        bh=18iika8ykLLEdqYdvZw20RyqagpFzM4QR/VITsqp37o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EB2OixqkFqp6PXfsfzn0kp2ZM8EULSvPg5dzvF7BMquAiOjMlBZ5xMDctP1gAxmBR
         ExczqpmZEoi9cglinf1qq0caaE6f8tTveErFqGbL2mFti5vAjHINBRx/dC24C8ROjO
         KZqJmQqLYgiHETEbcQAj9kVS3sdsYpQnqm7FznfESm07VapeNAr3LYn7E13ELs+xaO
         80OaX5peySjthdlA551GWXHjXspndntjl9zISUnTQOssVdHQepCadxzqdCR60Duapd
         PGkeqbjXxz0YK48OoOEFM05arg9i/nvvjXCHOmJcQc92XrfTOfn5jN+/q1paUmMVGr
         d6zAXcTTtpIng==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qfaTm-0004NL-2r;
        Mon, 11 Sep 2023 08:33:02 +0200
Date:   Mon, 11 Sep 2023 08:33:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.5 30/36] arm64: dts: qcom: sc8280xp-x13s: Add
 camera activity LED
Message-ID: <ZP60ngCV3hhNZiX5@hovoldconsulting.com>
References: <20230908192848.3462476-1-sashal@kernel.org>
 <20230908192848.3462476-30-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908192848.3462476-30-sashal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 03:28:41PM -0400, Sasha Levin wrote:
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> [ Upstream commit 1c63dd1c5fdafa8854526d7d60d2b741c813678d ]
> 
> Disappointigly, the camera activity LED is implemented in software.
> Hook it up as a gpio-led and (until we have camera *and* a "camera on"
> LED trigger) configure it as a panic indicator.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Link: https://lore.kernel.org/r/20230805-topic-x13s_cam_led-v1-1-443d752158c4@linaro.org
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is a new feature if anything, not a fix. Please drop from all
autosel queues.

Johan

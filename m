Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DE97CFCD2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346104AbjJSOeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346129AbjJSOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:33:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF2F183
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:33:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDB2C433C7;
        Thu, 19 Oct 2023 14:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697726010;
        bh=xgVyBZXxarbbLo4QRvBCDWw7XWRhUVfX8YK4qZOKB7M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ujmT1g95/lDIRqvPJsS17eYFoHPKwR0eToYJPQaYcsw3Q7v3PWnErc3e2DPXkw4x2
         jxdcSKSRoNYPy437InGkKYRgiXxkzFstM+kWLYforEYs21ZWTHkS8L7dFlUwD0Vbqt
         KaA7B8+K2GFgoXj6kw9fSdXzlZh8Wz/sCyKFZv0NUGYUBIxCj1LU5418mIGZvSfHCB
         6ZggFN+x+Zv2av4TPQr+0KTnb9Aoslbt+Tug0iYbGgRKwtxJWa5JXXpn5OzQGbFg4i
         RT9Ci1jZAZioxWhSNlh238IrHLw+Bv24quis2mgK+1cHncqF9PV5CcVEkdiGxTYF7z
         t+qrjnIAcgfCg==
From:   Lee Jones <lee@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20231017203603.2700864-1-robh@kernel.org>
References: <20231017203603.2700864-1-robh@kernel.org>
Subject: Re: (subset) [RESEND PATCH] mfd: Use i2c_get_match_data()
Message-Id: <169772600863.2516304.9870291046703773978.b4-ty@kernel.org>
Date:   Thu, 19 Oct 2023 15:33:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 15:36:02 -0500, Rob Herring wrote:
> Use preferred i2c_get_match_data() instead of of_match_device() and
> i2c driver_data to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> 

Applied, thanks!

[1/1] mfd: Use i2c_get_match_data()
      commit: 6d9c06f7e47bdf86cf1760f6bc5f41cb59fde829

--
Lee Jones [李琼斯]


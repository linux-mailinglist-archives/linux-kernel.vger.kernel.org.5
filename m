Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5A5762B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjGZGII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGZGIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:08:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F465C0;
        Tue, 25 Jul 2023 23:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D279615D5;
        Wed, 26 Jul 2023 06:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E55C433C8;
        Wed, 26 Jul 2023 06:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690351684;
        bh=qwTN9sZdB4un1rOE72fTxahHTpYGadYD3rVwkG7h6E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WN5aRQ4p3eJ1+RE115+5rGf4t+kkhfxuVZSe3zb6C8dTxssB1okR+2XFaliZP/D/W
         Eo/YjCAfCT3nD9ImPOxNhMEk605iefQjM8DNIRR+r7SeiFLA/CcA7+/CFmLSDeOkFp
         THUUlJZdhYHl6sujllBp2Rqo7H/AMez+3I2KH7aY/TFARpXG3uzGwKoH45KceP/197
         otRlzLjoIo9yUdIItT2QQmDcC29iArvUl52tsPEbT9/yCLZT2mWIpwUo9D3Kk46S0R
         OMDeg3J4GPAZxp/alaT4EfurZXoEVWjfeWSHNqyKlNKIQdWxaZLZrOTIbGA7k2B/s9
         TkSUP+nDZ+IlQ==
Date:   Tue, 25 Jul 2023 23:11:17 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     qaz6750 lzy <qaz6750@outlook.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: add uart13 node
Message-ID: <vg4muvoornyxxs6oiepdr5lkkoobujxydixwu6n2mv3lezc3xn@vz675x4jc6t5>
References: <SY7P282MB37870BD990E8EB855A735E15B203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SY7P282MB37870BD990E8EB855A735E15B203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 03:22:38PM +0800, qaz6750 lzy wrote:
> Bluetooth on SM8150 requires uart13
> 
> Signed-off-by: qaz6750 lzy <qaz6750@outlook.com>

Forgive me, but is that your actual name?

Regards,
Bjorn

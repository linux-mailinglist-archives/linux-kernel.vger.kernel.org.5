Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F477A6F21
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjISXEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjISXEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:04:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3DA18C;
        Tue, 19 Sep 2023 16:03:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE3BC43395;
        Tue, 19 Sep 2023 23:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695164633;
        bh=PdqeUwdYIZid0SRQB6tzM0l40ESLOa1+HI9+zaX0JGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cnaEKfHvxfATbROVELzxdpIDU1eHZ+gi5Y70///kgyJqBcihCLNQUvzO/xUTWN2r+
         PMLTpsM6EfBrNbMQ81xwXcbBLI0l8NnKOI+t+a7YPFIqlxIfR2rgBI1FqvECf1Q3VE
         5CtmEmAo201qV961dFBkAJNz9WOOxxBdgohym7QEuA42gynvsJaMVYw3h+CblLGzwq
         EmNiqFAzeJSaQdSkfNbzBED8g6pw6tLZm8N/Qhh6bdf4Um8Zq4OYlU3kP/kjZOtY7k
         jr/lnUe2+53dTltopzA3tO6Rn0vzEthVg+qo65ca0CDt/pPRZi9/MIkgzVJ+ElfcLZ
         ww83GJGTaILwQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jasper Korten <jja2000@gmail.com>,
        Siddharth Manthan <siddharth.manthan@gmail.com>
Subject: Re: [PATCH 0/3] Add display panels to gt5 devices
Date:   Tue, 19 Sep 2023 16:07:41 -0700
Message-ID: <169516485996.787935.17825880295436617116.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230725-gt5-panel-v1-0-7c787e33a614@trvn.ru>
References: <20230725-gt5-panel-v1-0-7c787e33a614@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Jul 2023 16:52:00 +0500, Nikita Travkin wrote:
> This series adds display panels to Samsung Galaxy Tab A (2015) tablets.
> 
> Both gt58 and gt510 gain display support and backlight is controlled
> with the DCS commands.
> 
> While at it, also enable touch-keys on gt510.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: msm8916-samsung-gt510: Add display panel
      commit: 4389a650323afe947900f631322fa4db4993d356
[2/3] arm64: dts: qcom: msm8916-samsung-gt58: Add display panel
      commit: 43525a7a96acad0648577770b84894af8dcb10d2
[3/3] arm64: dts: qcom: msm8916-samsung-gt510: Add capacitive keys
      commit: 20ef4f6445681217c0cb49dc21402cb2836b22aa

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

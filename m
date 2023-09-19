Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFAE7A6EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjISXDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjISXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:03:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427ABC6;
        Tue, 19 Sep 2023 16:03:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F064FC433C9;
        Tue, 19 Sep 2023 23:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695164616;
        bh=/Dcw7zKC8BcBHNTeIR44kvNUH+eJPDiCfQUsI4Z5I54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rCclC7fIhDJmgNDXlHqsdnjDeyHaEABcJWcMB2oy6ta2zyQ7K3TIfp0Xi/73mq5ti
         NrCTFJGnwrvfkkl0vbIfeogl+eXNyzWiuPbXgyQpJg3TiCm/JzCCt9QlQFn6O3NOnZ
         8rkVxX/NzgEZZtkIuG7iaJ47hnaWpksnrbaL0cS1j5ybgyfncJAgtC9Dgf5e8qImOT
         sns4X861QhvvPXJNiuJw1wpKIu8vpAws8wilxkQ1fy0ATZZKtRNv1fWpjS2gOtHOzL
         CEVgoXV60Fms9j8TVrogasL1Se4NGh0b8LhP3TcCM4Mtl5x97q9QJd6riCQtE6w++0
         OOTC4kW7xY1uA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sdm630: Add support for modem remoteproc
Date:   Tue, 19 Sep 2023 16:07:28 -0700
Message-ID: <169516485985.787935.13554174726198807178.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230719093458.2668842-1-alexeymin@postmarketos.org>
References: <20230719093458.2668842-1-alexeymin@postmarketos.org>
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


On Wed, 19 Jul 2023 12:34:58 +0300, Alexey Minnekhanov wrote:
> Modem subsystem in SDM630/660 is similar to MSM8998 and
> device tree node for it is based on the one from msm8998.dtsi.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm630: Add support for modem remoteproc
      commit: 09f1642eca6eb6d25a630214098350dc02917954

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

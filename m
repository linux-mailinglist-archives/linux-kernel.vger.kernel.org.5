Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76A67A7144
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjITDzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjITDzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:55:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704ABE5;
        Tue, 19 Sep 2023 20:54:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DBEC433CD;
        Wed, 20 Sep 2023 03:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695182097;
        bh=UlorBZR7jwpwSkHXqDVO2Qf0PvrylOVR+7VJ/cpsXZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAtNUK+6no9nEmb2ndarCfuP+BGAIRzWL5JU5/TlZgyef43ijLWVUk6Ml81OgOmG2
         elLAcCbqq1KunSuSW0J/e2g/NNwob06iWvN6Z5U752Gi1HyPIPXV77ky48JV7zWr6X
         MsVhSpSE8O3CwVIyVL8JIAzGTxnctxY2jSpYjQfhfNXkzhDxcOcsKVBxgqxyypxF1H
         1fl/nSa8R9Z20JSvNSTpVH8Dxz4atuSDyW0fBwM58vxfJCiRwn9Qpo5e0Mw3B3m5WJ
         /xsSEYvvYY8Hexk72Dvww68WJ34nM8HR+oiz6k1zqIzEwrun/2qf/IOsczcqyiIe6P
         FF+VgggKnKqog==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/2] arm64: dts: qcom: msm8939-longcheer-l9100: Add initial dts
Date:   Tue, 19 Sep 2023 20:58:48 -0700
Message-ID: <169518233718.1055386.6163446408058250462.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827-bq_m5-v4-0-f8435fb8f955@apitzsch.eu>
References: <20230827-bq_m5-v4-0-f8435fb8f955@apitzsch.eu>
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


On Sun, 27 Aug 2023 10:47:58 +0200, André Apitzsch wrote:
> This dts adds support for BQ Aquaris M5 (Longcheer L9100) released in
> 2015.
> 
> Add a device tree with initial support for:
> 
> - GPIO keys
> - Hall sensor
> - SDHCI
> - WCNSS (BT/WIFI)
> - Accelerometer/Magnetometer
> - Vibrator
> - Touchscreen
> - Front flash
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Add BQ Aquaris M5
      commit: 9905205541d2020e45da5ffe9787b4a2e53cc199
[2/2] arm64: dts: qcom: msm8939-longcheer-l9100: Add initial device tree
      commit: 27da4fd325c371e1ddbb4fc46629e2caf8f73f07

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

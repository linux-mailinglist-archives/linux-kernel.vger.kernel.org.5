Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC938099D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573073AbjLHCyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbjLHCxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED671BDA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8B1C433CB;
        Fri,  8 Dec 2023 02:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004015;
        bh=2nB+32047idLop8zJ39E01kxCGpV9yx0H3PuyQtwUpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1pd9bo/Pz7Y/fljFZxAfnH5m4ngym+e1U6la8eq+ewCVeWu2aW0YM0zkHDGIAn27
         iTLnBOCb/G79zFxjI+C560ZyL/V8aamdYDS79HRaU1LF57pScXLHuep+2iqEb6T+ic
         x99ftxs9lMPUf/eGeUMQ7Tdn8iLCxZLT8ds67aME/PL15bKZ4qu08d8fEpJOdQJ9R9
         LE8K/zwzZ1zf1g9wsNpdRPmPjr366Dhm2XM7ym6Skx0gH5Oz3rgvtndQiU9Y3NlN5M
         CsDyOAzzYibXa3K8st4c8ImsSwXs0YKy4ODRBMhgGl/lK+aN0J21Go53MMvK4um1D1
         IF6V2j+Mq+u7w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>
Subject: Re: [PATCH] dt-bindings: arm: qcom-soc: extend pattern for matching existing SoCs
Date:   Thu,  7 Dec 2023 18:57:40 -0800
Message-ID: <170200426925.2871025.2044792437170118709.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120100617.47156-1-krzysztof.kozlowski@linaro.org>
References: <20231120100617.47156-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Nov 2023 11:06:17 +0100, Krzysztof Kozlowski wrote:
> Add missing QDU, QRU and SDA platform names to the pattern matching all
> Qualcomm compatibles.
> 
> 

Applied, thanks!

[1/1] dt-bindings: arm: qcom-soc: extend pattern for matching existing SoCs
      commit: 08105d9a5490551d86d95729bbbd3161652850dd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

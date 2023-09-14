Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823097A09FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbjINQAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241349AbjINQAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:00:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C74A1BDD;
        Thu, 14 Sep 2023 09:00:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EF1C433D9;
        Thu, 14 Sep 2023 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707232;
        bh=DihOCs/1P+ZYQX6g6Ox3tDlhitMMI7Usg/cYg6dZaNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLFY/RED3rc26Lfylm+vVSV4H6WWnBZ6ROB9AJgMOzwP9Y837P1FrmbRZe+nxLoY1
         4NQXxFThdRHpVosMr/Xex1o56ZfMtOwSfUchCayju7ZW43gVdcyzT4Lf3w3OflyYZ7
         DaiS1Oa0PuJu7aUMQj7nUt9LsGdEan7acjT7Suwff8GpFA2bYWuJ0cS5GMR/QD2f9E
         IM8TGM31Z7KWBKQZeN2r3V9gE82yHxKDi400hmGO+olKZdJxCjF2zD0srp2gjhiDwe
         SgKbqz0LMDWpVpkjf7bxuLJWykv8/w+0p35l8l/nMACRQzWJcn1siMTcrWuLyx009/
         24R8qmnsTMbYA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/2] arm64: dts: qcom: sdm845: Fix PSCI power domain names
Date:   Thu, 14 Sep 2023 09:04:20 -0700
Message-ID: <169470744884.681825.16549416026586738722.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912071205.11502-1-david@ixit.cz>
References: <20230912071205.11502-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 12:42:03 +0530, David Heidelberg wrote:
> The original commit hasn't been updated according to
> refactoring done in sdm845.dtsi.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sdm845: Fix PSCI power domain names
      commit: a5f01673d3946e424091e6b8ff274716f9c21454
[2/2] arm64: dts: qcom: sdm845: cheza doesn't support LMh node
      commit: 197ae69d1caedb3203e0b189a39efb820675fd5c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

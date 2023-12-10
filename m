Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106D880BE27
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 00:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjLJXV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjLJXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:21:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB09C111
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:21:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727FAC43140;
        Sun, 10 Dec 2023 23:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702250481;
        bh=Ebg1Pl+ZMLOou6Mg4RWGn2tcbWhqseOKxzJU8l7+g5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvONUFbckoc7EUhr3XlhCT0yKXPkcuT1jKoZIKi6Lz4T52CeYvmqgLGIcR9To8UWB
         qeaRBoBqcX+C3Oz/Cdj/ln7bFGp3v8eY6Btiwa7I2sFjbx0NdGKN9X08g3nNc4Xc2/
         LUnm9hjJawpeVKxRTkSCPzsEbUbcoBaM3d7y15k68oAT8M9Hz8NL179ux4IaIfWIWY
         kkX5R1IIdE27fjFXE4G99bQ+LnS9xxGUrZiZZ6x9cFQIPVhp+AzvwwJyiI5FuLw7pD
         7D0tYO1UFqwy4U1VO5z1bK2QcxVebJezhGFp7TCHYNJX8sNNq46VHjGx8Xuf+2Zg1b
         HX6IK6gU4jF/g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8650: Add DisplayPort device nodes
Date:   Sun, 10 Dec 2023 15:25:42 -0800
Message-ID: <170225073870.1947106.12491933482797485031.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208-topic-sm8650-upstream-dp-v2-1-69dab3d074e4@linaro.org>
References: <20231208-topic-sm8650-upstream-dp-v2-1-69dab3d074e4@linaro.org>
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


On Fri, 08 Dec 2023 13:16:45 +0100, Neil Armstrong wrote:
> Declare the displayport controller present on the Qualcomm SM8650 SoC
> and connected to the USB3/DP Combo PHY.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8650: Add DisplayPort device nodes
      commit: 990b6c928b212d930ae8b002dd86043cc4a302ba

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

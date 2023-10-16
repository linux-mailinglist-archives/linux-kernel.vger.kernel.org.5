Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688FB7CB246
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjJPSWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjJPSWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E02A7;
        Mon, 16 Oct 2023 11:22:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAD9C433C7;
        Mon, 16 Oct 2023 18:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697480525;
        bh=4IXyrwzYOLnqIcmXT7Mu1qH4NasffBNzcPLLevm/ZZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrhKsf8nQm3cw57Jskq1lrMdOd8F7cP1NdqOddQmklJmS6pQnnW1oB0dhVRTP3zrH
         MdLBDnL6MAUuSbk8Gav4PgThusxMD8tr/2Zpu1DQ44zpnDH6L/XF92h+o0VWUdL4Dd
         p3YTv0lnZVUgMKWRD0UoM3r3/KLikCU1026FGU/AEzexs/rj11TezlbHgPSeJ7BMCm
         sc/BNcOfcwRKSwaBAOmkDve4BTL8KcuJ61AgK9lHDEstJkfrPLsO/wSSCa2uxaPT1R
         viWpbINWZq2fsTGYzQS4AmgIAiXth9FVSkGXeCtL4A0nUVN26SaDvcLOkT+LQm9NPj
         CQdpMGG1ue35A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] SM6375 features
Date:   Mon, 16 Oct 2023 11:25:47 -0700
Message-ID: <169748074955.1245023.6551188335111911232.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927-topic-6375_stuff-v1-0-12243e36b45c@linaro.org>
References: <20230927-topic-6375_stuff-v1-0-12243e36b45c@linaro.org>
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


On Wed, 27 Sep 2023 11:21:39 +0200, Konrad Dybcio wrote:
> Enable modem & wifi on sony 10 IV, add bt uart to the soc dt.
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: sm6375: Add UART1
      commit: 1529f6a43cc4feeb78f6063ae3ae7d8003594de6
[2/4] arm64: dts: qcom: sm6375-pdx225: Enable MSS
      commit: ea6b3c61559f647d183322fc5431f2a5e78123d3
[3/4] arm64: dts: qcom: sm6375-pdx225: Enable ATH10K WiFi
      commit: 6ffcd65f27d7d083b9bfae56c9b5fe1a0b7500f8
[4/4] arm64: dts: qcom: sm6375-pdx225: Add USBPHY regulators
      commit: 2ea7de2f804432dd17bcfa97576f0ccf2054cd6e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

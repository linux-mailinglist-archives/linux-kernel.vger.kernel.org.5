Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C5F7A7151
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjITD4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjITDzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:55:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C717DE;
        Tue, 19 Sep 2023 20:55:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3F7C433AB;
        Wed, 20 Sep 2023 03:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695182105;
        bh=H8Ozx7DKlJhostq/HOXtXf+BZQGn8zz+FsnkFGEab4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaRm1rSj9EIsEegUJ7W9D/WobZyz/SaSAd7IyZTphWqLMwiHRULXJZgmR8EckvQxX
         9IdFOhKNVsyICSyUO1ZA29U14iKaq/qgk36crkhQdtFkV7g1eUGVcg3bvOXTsDM33a
         84Kx6zPqvrZmgtWXgYPKHzuphLXEunaVU/4vR3RuZLrwir6UGl0J39qdpf1PO/Ao+f
         8r3+QpxTflr/Tn81R44OU7ai8c3cJV8yBvqhECVT8LWOg0UM2k7jrcmhJXti0J4y13
         tbZNBdp9ipQ82Dnrc/3FrSc8JvueC8LAn+Sd2tzGnYwjMVj20e/Nsgq46i6x2JcEy4
         p8Y1O5AeiIQmw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: split pmr735d into 2
Date:   Tue, 19 Sep 2023 20:58:56 -0700
Message-ID: <169518233719.1055386.15483744962512505307.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831-topic-sm8550-upstream-pmr735d-split-v1-1-98e632636415@linaro.org>
References: <20230831-topic-sm8550-upstream-pmr735d-split-v1-1-98e632636415@linaro.org>
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


On Thu, 31 Aug 2023 17:25:49 +0200, Neil Armstrong wrote:
> The second PMR735D PMIC is not always presend on SM8550 based devices,
> split the pmr735d.dtsi file in two so boards files can only include the
> ones present on the platform.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: split pmr735d into 2
      commit: e96c4d53d45e1ef0bcd40f2acfc30dfdea4b9131

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

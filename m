Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D398020BF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjLCEvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCEve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:51:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD74D114
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C80C433CD;
        Sun,  3 Dec 2023 04:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579100;
        bh=ryt2h7SkbYQcn12xnCcjVqqS+Lbdhr5WerU/Zo8DJWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OfmrlXWlhbIE7h6iKf2cASBdiB80r7n697VPkclNShPdg/V9W7MCrF86RpO8cy3en
         sof730zloJV/UmoDUtxDSGQ/nTon0w+LgiWxCpG4y1qn5W/dS0icFU5EbSTDJWuSlJ
         jtKKDyC9EIK/INYJx+13z7evbfw67J/LQFDPUsZAQaZ4SST1IWIwlhjj+Q3FKXNCLo
         56oj4/EXlAZ8qnVfMwzjXpBhlSsVhtBWPB4ZxsBz6SgJP8Rl0PPlSQqgrcoxBH+k/C
         gOAduZNCwFotwCQu6W0BVlJzFjMwSXiYmpANvxucu9qfG1QFuc8yBsIlHuP8w6Pq6+
         lMCOJU9LKxN/g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8939-longcheer-l9100: Add proximity-near-level
Date:   Sat,  2 Dec 2023 20:54:31 -0800
Message-ID: <170157925819.1717511.9438209599308488014.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126-bqm5_prox-v2-1-b7defc3979ac@apitzsch.eu>
References: <20231126-bqm5_prox-v2-1-b7defc3979ac@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 26 Nov 2023 22:46:20 +0100, André Apitzsch wrote:
> Consider an object near to the sensor when their distance is about 4 cm
> or below.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8939-longcheer-l9100: Add proximity-near-level
      commit: fbe0870c48ac84f117860096048055a4f078a976

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

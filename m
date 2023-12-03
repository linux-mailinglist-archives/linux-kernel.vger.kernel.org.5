Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3183F8020BE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjLCEvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjLCEvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:51:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D414B114
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9117BC43395;
        Sun,  3 Dec 2023 04:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579103;
        bh=KxxZEEg473444shSwsQVNT62EcqGr7edvl7KfR+ahCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6iXsYuXZ6QQ2wJt3hqVo5Xg7Ymt46/SdGxPjwcj4z5CJGYOOoq+Uv+dLOORVdH9t
         f2EZFAPJXwK+9Cnhvh6ZrywJB9Hp91KZFtwTqBgd2unLBUEEWSmNRTUeoG194I7FVz
         ZoNLHYwrh00gJUH2I6EXgyQpMDs/YxsRrtZJJaoexyhwpAjjhsyuNf7KRSlZPZ6k3l
         VTzCnJkBNz38NVLQDKmE85nmcPOQ6vJkFCQhMX0I3nim5MaDmEDmtksN2r4jheb+iX
         5Il67n9rsptVrSXLRXHiQbEQDpmRYM7NTHyRegKdOlftoxtNB5LZVr6VO6iljDk56E
         wiaXKZ96gEp1Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] RB2 bluetooth
Date:   Sat,  2 Dec 2023 20:54:34 -0800
Message-ID: <170157925818.1717511.140667965490935754.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120-topic-rb2_bt-v2-0-4bbf266258ef@linaro.org>
References: <20231120-topic-rb2_bt-v2-0-4bbf266258ef@linaro.org>
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


On Mon, 27 Nov 2023 12:23:26 +0100, Konrad Dybcio wrote:
> The bluetooth module on RB2 seems to work ootb with the WCN3988 setup.
> Enable it.
> 
> Scanning for devices works, couldn't test pairing on a remote board.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm6115: Add UART3
      commit: ba5f5610841fad3b15c69c6949ed6e19bd5b466e
[2/2] arm64: dts: qcom: qrb4210-rb2: Enable bluetooth
      commit: cab60b166575dd6db4c85487e87a9b677e04c153

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

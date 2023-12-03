Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6743C8020D4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjLCEwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjLCEv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:51:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3065210EA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAEEC433CB;
        Sun,  3 Dec 2023 04:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579113;
        bh=1qr6M/RXnieLfllIA8ZsAQ+xSrQC5lGllwk0fEQ0HV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpKBXyuFMHCWGT2i0foR1WwEI1eaZR1HqScX4JPA7faYQH9DN6a6H4N2EwaTTie/X
         TMZXlFhT4Iz8h+EhV4ldBwo/q5fMRYX58Cmwi9G7TsCX+sx58mld3MQhVbNjA3y+Dk
         P5CnD+jvKuoiRXQ8F7UdqdrKcRJuMcDlCBJDyyWfLCd2WTsWQIm1mbgBnleCzEVc6X
         EicBJ5QA0R9VDR2pOvpoV5lBVgkkKe3D0fJ7Ix/X9zf1fofPy7azAbBtgdzDhmoP48
         our8y0CKfw/4JtDtaURI7m0L7ELk+8wf8RKMRChqU19WvF6aVl/vnnh2GxS5waYAui
         WnpPIFziZR+bg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 0/2] Small dtsi fixes for msm8953 SoC
Date:   Sat,  2 Dec 2023 20:54:41 -0800
Message-ID: <170157925829.1717511.13837775951569273459.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231125-msm8953-misc-fixes-v2-0-df86655841d9@z3ntu.xyz>
References: <20231125-msm8953-misc-fixes-v2-0-df86655841d9@z3ntu.xyz>
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


On Sat, 25 Nov 2023 13:19:26 +0100, Luca Weiss wrote:
> Fix some small things in the qcom/msm8953.dtsi file to make dtbs_check
> happier than before.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: msm8953: Use non-deprecated qcom,domain in LPASS
      commit: 2e0dcbf164fb02d2558bd08b9609a30ef5935912

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

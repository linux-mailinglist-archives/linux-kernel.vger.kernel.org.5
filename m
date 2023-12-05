Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD96180456F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbjLEDCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjLEDCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:02:12 -0500
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33FFBF;
        Mon,  4 Dec 2023 19:02:17 -0800 (PST)
Received: from Vostro-3710.lan (unknown [119.122.215.53])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id C6E6F8000A1;
        Tue,  5 Dec 2023 11:02:04 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     krzysztof.kozlowski@linaro.org
Cc:     agross@kernel.org, amadeus@jmu.edu.cn, andersson@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: ipq6018: fix clock rates for GCC_USB0_MOCK_UTMI_CLK
Date:   Tue,  5 Dec 2023 11:02:01 +0800
Message-Id: <20231205030201.12694-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6f4f7903-c112-428b-8082-a8eca7c5981d@linaro.org>
References: <6f4f7903-c112-428b-8082-a8eca7c5981d@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkoaVh4dTx5MGE5NSUpMH1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKQlVKSUlVSUpOVU5IWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8c37ecf460b03akuuuc6e6f8000a1
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PUk6GCo5Czw4Eg0MMDNWSFYM
        DxowFBNVSlVKTEtKTE9OSElOQ0tNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        QlVKSUlVSUpOVU5IWVdZCAFZQUpNTkg3Bg++
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> That does not look like XO, but GCC_USB0_MOCK_UTMI_CLK

I don't have the datasheet, but the reference clock (XO) is 24MHz, 
and I receive the following warning:
clk: couldn't set gcc_usb0_mock_utmi_clk clk rate to 20000000 (-22), current rate: 24000000

Thanks,
Chukun

-- 
2.25.1


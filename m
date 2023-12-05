Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F2C804550
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbjLECtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjLECtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:49:11 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 18:49:15 PST
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3599CA;
        Mon,  4 Dec 2023 18:49:15 -0800 (PST)
Received: from Vostro-3710.lan (unknown [119.122.215.53])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id C6ADD8000C4;
        Tue,  5 Dec 2023 10:30:06 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     krzysztof.kozlowski@linaro.org
Cc:     agross@kernel.org, amadeus@jmu.edu.cn, andersson@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: ipq6018: Add QUP5 SPI node
Date:   Tue,  5 Dec 2023 10:30:03 +0800
Message-Id: <20231205023003.10278-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <67ecd9c3-40e3-40c6-b904-9898556af409@linaro.org>
References: <67ecd9c3-40e3-40c6-b904-9898556af409@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTB1CVk8fSE9PSksYSRlKT1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKQlVKSUlVSUpOVU5IWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8c37cfb037b03akuuuc6add8000c4
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzY6ORw4EDwzQw0*FDMjCS8M
        NA1PC0NVSlVKTEtKTE9IT0tMTEtPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        QlVKSUlVSUpOVU5IWVdZCAFZQUpOS0k3Bg++
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why are you sending this separately from the UART patch?

Because they are independent and have no dependencies.
Should I send these in the same thread?

Thanks,
Chukun

-- 
2.25.1


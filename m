Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B90679F0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjIMSRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjIMSRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:17:34 -0400
Received: from smtp42.i.mail.ru (smtp42.i.mail.ru [95.163.41.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB3519B6;
        Wed, 13 Sep 2023 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=J4ozN4TvGXjRfQugwcXzBt2rr2u1pEJHtcwnJx9PImE=; t=1694629050; x=1694719050; 
        b=ngPLQxprHHj58DshAodVpxs5d6zqIi02hD/Yrp4b4EerD1QsFciigC+MhZLhZYvkKINyy6HzyXE
        xcbW7BTNs6d8hkVXsxlqY4pFWcFkIBwGsQJdXPcmFTkJM3sBZXIzdEH6sclNaJPOWQmaasF1Y/es/
        2k+u5uq9+PjThJZU530=;
Received: by smtp42.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qgUQZ-002CNz-2e; Wed, 13 Sep 2023 21:17:28 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add Soc ID for SM7150P
Date:   Wed, 13 Sep 2023 21:17:21 +0300
Message-ID: <20230913181722.13917-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913181722.13917-1-danila@jiaxyga.com>
References: <20230913181722.13917-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp42.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD927CFE6CA1630A10C1A6EB86C92C8A7C29A09A03CE3E311D400894C459B0CD1B9FDE66DF3973B744F062739E7DFC40815E810CAF9E72F1A42B242013FB95F71DC
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7548C33FFD72831AFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370AEA98ADD099B586EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA2F3A2EF703BA7337C8D139D8503B0ADECC7F00164DA146DAFE8445B8C89999728AA50765F79006374F09588CB15B21E6389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC87AE820D2C17D0E56F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C16F36C0CB6DCE1229735652A29929C6C4AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C37AC6CA6474BF70F7BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7D2B2750C7C54257D731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5CE31644ADE82A1EF42B845A496872F88420AFC664287F976F87CCE6106E1FC07E67D4AC08A07B9B0CE135D2742255B359C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF30452704F39951BE4497030D9FE68EB4284C7A636725B3628D90917D3BD655961D17C9D1E1925344C4B8F2E8CFB8F5716E0AD8F4922A3C751D5D3B582E26C9376E346BF9FA413E554C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojoMTWofjSWSRT/QU/mS12Fg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981796B0F5A6336A708102387EA2F536F46976AF1CB91E68E81643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ID for the Qualcomm SM7150P SoC.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index be12e1dd1f38..036124336d17 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -193,6 +193,7 @@
 #define QCOM_ID_SDA439			363
 #define QCOM_ID_SDA429			364
 #define QCOM_ID_SM7150			365
+#define QCOM_ID_SM7150P			366
 #define QCOM_ID_IPQ8070			375
 #define QCOM_ID_IPQ8071			376
 #define QCOM_ID_QM215			386
-- 
2.41.0


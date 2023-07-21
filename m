Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6A775BD16
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGUEGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUEGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:06:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928461BC1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 21:06:42 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L45e4o024913;
        Fri, 21 Jul 2023 04:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wtVClhU3klFGG6u/OlX4qZpOcqjROVfGqC4YbZEwYdc=;
 b=KLFjRdKFkbhGbII58ntoOSyX/ZDW40rhCXsYsBKlwZJqo4MVcKqpkfkRjZEZoH5b8SR4
 y+0v7aSclh5vCnMP/0ztKmQwadDzKz6mmHdFT5bH9il6qiNVv62qEjW/s6U+9GsaMfGz
 fUCU1z9kH6e6ZvPiPKccJvIu8c/N/ugOOekJAeMB7Uh5Y6FZltox3lsZXYABq0ZbyKYH
 RWuZ3wy1LFy2coyZJyr+DBLkUNKcSkOf5ILEDbuOsZjDGu4XXTuXrqcOuAjoEJXbZ7bY
 n5f256Bf7tjUNMqLi8Mn9G0Dcr7rWKdwiWqrxlDzqeXLM2F+omsHp34yO7pPx3y1Mzcq +w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxsxeb5r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 04:06:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L46SCq001495
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 04:06:28 GMT
Received: from [10.216.41.167] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 21:06:25 -0700
Message-ID: <e1c6b11e-b550-b25a-a02f-0ef8be1eb080@quicinc.com>
Date:   Fri, 21 Jul 2023 09:36:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: drivers/pinctrl/qcom/pinctrl-ipq5018.c:244:27: warning: unused
 variable '_groups'
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
References: <202307120814.vWPY6URk-lkp@intel.com>
 <CACRpkdbYPAiOa4QU+PUxVjcOtkBT2O7fogh51VvSEbFPutH7ng@mail.gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <CACRpkdbYPAiOa4QU+PUxVjcOtkBT2O7fogh51VvSEbFPutH7ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A69ThUj3qWw7VaMAhHRwct6IMjSa-p_Z
X-Proofpoint-GUID: A69ThUj3qWw7VaMAhHRwct6IMjSa-p_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_01,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=636 clxscore=1011
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210037
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 7/21/2023 12:51 AM, Linus Walleij wrote:
> Hi Srirachan, Bjorn,
> 
> is this warning valid or something I should ignore?
> 

   oops, will fix this and send a separate patch.
   Did not see this with the default defconfig build though.

Regards,
  Sricharan

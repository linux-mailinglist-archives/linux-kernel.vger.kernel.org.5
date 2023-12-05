Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B3E805BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjLEQgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjLEQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:35:59 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BA0199;
        Tue,  5 Dec 2023 08:36:04 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5EXWIg028302;
        Tue, 5 Dec 2023 16:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AgdLlmCBIIBgD/CobFHZaIHStyC0CizUtHM/DbAQ07k=;
 b=QSbyUUAak0dkC/ofk8gmqMUiUVFbZVJ4sq71wW9c4ff3CDzhS4tnyY32F7GxVHQ0vQm9
 yCVbdbAeWZJQ0qoHy2O2b1z0b95LR5+AxywuLteHUwd3T0Ih+eaPQ2jBn4rzrCvtUqNR
 RvguB4wFgovlFbLbuNhaH9TKGUJ6aaPAbxu4HXd88NuwfAGiEF5vCJ/7P2bGGSqWw/Nq
 mQXqr7QHFtWZDTcEkTzmR4ihsfMANjUEIp25rsJgf1CH+wXw8DSsINgaTXzJl6PFUhHH
 K5UOPVKKOlCGxcrgzHU9eJFoS7iAeuPEeMl0DKwpcj/4cEoetoCmvaBsxpiUYWhcmqV7 0A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usghcu60n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 16:35:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B5GZwVn015957
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Dec 2023 16:35:58 GMT
Received: from [10.50.1.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 08:35:53 -0800
Message-ID: <33684abf-485d-32fd-6ca2-6168b4bab61b@quicinc.com>
Date:   Tue, 5 Dec 2023 22:05:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 12/13] scsi: ufs: qcom: Sort includes alphabetically
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-13-manivannan.sadhasivam@linaro.org>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20231201151417.65500-13-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dY8vgtF63FV-BumCkun5LzIQzelGwNmQ
X-Proofpoint-GUID: dY8vgtF63FV-BumCkun5LzIQzelGwNmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_11,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=937 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312050129
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/2023 8:44 PM, Manivannan Sadhasivam wrote:
> Sort includes alphabetically.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/ufs/host/ufs-qcom.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 824c006be093..590a2c67cf7d 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -4,26 +4,26 @@
>    */
>   
>   #include <linux/acpi.h>
> -#include <linux/time.h>
>   #include <linux/clk.h>
>   #include <linux/delay.h>
> +#include <linux/devfreq.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/interconnect.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> -#include <linux/platform_device.h>
>   #include <linux/phy/phy.h>
> -#include <linux/gpio/consumer.h>
> +#include <linux/platform_device.h>
>   #include <linux/reset-controller.h>
> -#include <linux/devfreq.h>
> +#include <linux/time.h>
>   
>   #include <soc/qcom/ice.h>
>   
>   #include <ufs/ufshcd.h>
> -#include "ufshcd-pltfrm.h"
> -#include <ufs/unipro.h>
> -#include "ufs-qcom.h"
>   #include <ufs/ufshci.h>
>   #include <ufs/ufs_quirks.h>
> +#include <ufs/unipro.h>
> +#include "ufshcd-pltfrm.h"
> +#include "ufs-qcom.h"
>   
>   #define MCQ_QCFGPTR_MASK	GENMASK(7, 0)
>   #define MCQ_QCFGPTR_UNIT	0x200

Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>

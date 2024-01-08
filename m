Return-Path: <linux-kernel+bounces-19601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AD2826F70
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FCB1C22824
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB63B41766;
	Mon,  8 Jan 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d5+ipSyA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1EC4174F;
	Mon,  8 Jan 2024 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408CD4V9012010;
	Mon, 8 Jan 2024 13:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GpsHIDZ+3lWGB8e2dvgrmsAmXtLnEX2d7q55g4o4vBc=; b=d5
	+ipSyAZQ48j+60AMVsfUQJ0w1ZVTSuMR3IUwgV2GvV2RrDE/0YTbXVHBnjM/9KWB
	3aN4Qj+1PJstlrsGEDBTwlwokifLq6p21yStoqymr9zOclTU8XYK4Ev2yrtrzg/r
	3gA5b8P3Kl5AB8ZnMfo0Hxvj2MDl0AdT6VUFXCGLjVmiBLgbOsVGiPMvNyLWVnKu
	RXCP2WNxRdyrPOQBTrtFzcWeJeoXU0c8N1pp/6wZviY3WkD2E7at8gdXjXW9lqLG
	XGabo9/R8WIBHS9r/axvfd5LclXYO3BwNkYrmABpkvGxZbzV3eyrXA9nxPo0iV2g
	aXoiP94+oAzJet0S5NHA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgch50q4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:14:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408DEPJL016711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 13:14:25 GMT
Received: from [10.217.219.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 05:14:23 -0800
Message-ID: <374ab3d3-21eb-4152-a285-ad0567ed32e7@quicinc.com>
Date: Mon, 8 Jan 2024 18:44:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: ncm: Fix indentations in documentation of
 NCM section
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Krishna Kurapati <quic_kriskura@quicinc.com>,
        Jonathan Corbet
	<corbet@lwn.net>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240108123602.10593-1-quic_ugoswami@quicinc.com>
 <2024010830-haven-sprawl-de51@gregkh>
From: Udipto Goswami <quic_ugoswami@quicinc.com>
In-Reply-To: <2024010830-haven-sprawl-de51@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5SsKCM7_ZnFN4d8ACyy0KFY7X7uLkHsj
X-Proofpoint-GUID: 5SsKCM7_ZnFN4d8ACyy0KFY7X7uLkHsj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=330 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401080113



On 1/8/2024 6:15 PM, Greg Kroah-Hartman wrote:
> On Mon, Jan 08, 2024 at 06:06:02PM +0530, Udipto Goswami wrote:
>> Currently, the section of NCM which describes attributes are having wrong
>> indentation.
>>
>> Fix this by following the correct format recommended.
>>
>> Fixes: 1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs")
>> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
>> ---
>>   Documentation/usb/gadget-testing.rst | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> This was reported in linux-next so it needs a "reported-by:" tag, right?

right, apologies!
Will address in v2.

Thanks,
-Udipto


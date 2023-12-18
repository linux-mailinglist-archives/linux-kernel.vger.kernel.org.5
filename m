Return-Path: <linux-kernel+bounces-3364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36334816B80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3775283A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE80419442;
	Mon, 18 Dec 2023 10:47:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ACE1945D;
	Mon, 18 Dec 2023 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 000531FB;
	Mon, 18 Dec 2023 02:48:10 -0800 (PST)
Received: from [10.57.46.32] (unknown [10.57.46.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4F623F738;
	Mon, 18 Dec 2023 02:47:23 -0800 (PST)
Message-ID: <1d57590d-2ecf-4bf6-9c8f-2a9d1ba08aaa@arm.com>
Date: Mon, 18 Dec 2023 10:47:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] dt-bindings: arm: Add support for TPDM CMB MSR
 register
Content-Language: en-GB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Tao Zhang <quic_taozha@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
 <1700533494-19276-8-git-send-email-quic_taozha@quicinc.com>
 <e5fbbfab-02bf-4eda-8353-87c54c307af1@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <e5fbbfab-02bf-4eda-8353-87c54c307af1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tao Zhang,

On 21/11/2023 07:24, Krzysztof Kozlowski wrote:
> On 21/11/2023 03:24, Tao Zhang wrote:
>> Add property "qcom,cmb_msr_num" to support CMB MSR(mux select register)
>> for TPDM. It specifies the number of CMB MSR registers supported by
>> the TDPM.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
> 
> I prefer not to take any new Qualcomm Coresight bindings or Qualcomm SoC
> DTS nodes with Coresight till we fix all existing warnings. I don't know
> how to fix them, so I need help with them. No such fixing happened so
> far from Qcom, so pushback is my only way to get any attention.
> 
> I already commented on this in other email thread.

Are you addressing this ?

Suzuki

> 
> Best regards,
> Krzysztof
> 



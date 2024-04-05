Return-Path: <linux-kernel+bounces-132798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F50899A67
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787131C2198F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563E2161912;
	Fri,  5 Apr 2024 10:11:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC38115FD0C;
	Fri,  5 Apr 2024 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311908; cv=none; b=jAqiDfJli5rAEUQuv2ruOmTZkhMhoMinHjJD8G6mH54dyAYFYNp3UcUbsKYatcbvamaA5GbDOxkF9NjVeLMoHUHNKS1mGzmzZ9fX4+Q9N0KS1kCuzLO/y5maxO0uC3grL0ZFIufBqr6CiLETK3LK8XIHfSPgZUKNmyET22Se2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311908; c=relaxed/simple;
	bh=YXh1j0mAl/w+isXu3JW1TAJnhD9Q8ez9KvAOttc6e9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kh90KwuXYNSX7vOGm5nNs+86fAuCcFIYeS5ysXr/txTk9YK0b4auodUUDC5TxTHNGxH7YIuPan2sIPc0c/DjIJZKqOjNe+WAzon0Y88+299JXNDdZqe3rkAtuQb+Wz6zamhq7Uh53QsOV9zOsVPbviLA2X9PL1swX1lfNvtxQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2229FEC;
	Fri,  5 Apr 2024 03:12:16 -0700 (PDT)
Received: from [10.57.74.176] (unknown [10.57.74.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A1243F64C;
	Fri,  5 Apr 2024 03:11:44 -0700 (PDT)
Message-ID: <3a1ff6cb-82f9-4767-b614-740f13379d8b@arm.com>
Date: Fri, 5 Apr 2024 11:11:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Update Energy Model with perfromance limits
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 sudeep.holla@arm.com, cristian.marussi@arm.com,
 linux-samsung-soc@vger.kernel.org, rafael@kernel.org,
 viresh.kumar@linaro.org, quic_sibis@quicinc.com
References: <20240403162315.1458337-1-lukasz.luba@arm.com>
 <20240405105600.000019fd@Huawei.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240405105600.000019fd@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/5/24 10:56, Jonathan Cameron wrote:
> On Wed,  3 Apr 2024 17:23:13 +0100
> Lukasz Luba <lukasz.luba@arm.com> wrote:
> 
> Typo in patch title.  performance

Thank you, good catch!

Regards,
Lukasz


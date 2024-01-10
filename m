Return-Path: <linux-kernel+bounces-22287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15A829BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A981C219F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBB7495F5;
	Wed, 10 Jan 2024 13:56:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D34A984;
	Wed, 10 Jan 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFE5E2F4;
	Wed, 10 Jan 2024 05:56:47 -0800 (PST)
Received: from [10.57.87.179] (unknown [10.57.87.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7D053F5A1;
	Wed, 10 Jan 2024 05:55:59 -0800 (PST)
Message-ID: <43f2fdd1-7153-4061-810e-f84bc9df40b8@arm.com>
Date: Wed, 10 Jan 2024 13:57:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/23] PM: EM: Refactor a new function
 em_compute_costs()
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com,
 amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
 len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io,
 wvw@google.com
References: <20240104171553.2080674-1-lukasz.luba@arm.com>
 <20240104171553.2080674-6-lukasz.luba@arm.com>
 <CAJZ5v0ij2aMzzhC3Ur0y0LSdnT0TypeH0DGSnsUPaxm6bDXcXw@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0ij2aMzzhC3Ur0y0LSdnT0TypeH0DGSnsUPaxm6bDXcXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/4/24 19:15, Rafael J. Wysocki wrote:
> Here, I would say "Introduce em_compute_costs()" in the subject and then ->

OK

> 
> On Thu, Jan 4, 2024 at 6:15 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Refactor a dedicated function which will be easier to maintain and re-use
> 
> -> "Move the EM costs computation code into a new dedicated function,
> em_compute_costs(), that can be reused in other places in the future."
> 

OK


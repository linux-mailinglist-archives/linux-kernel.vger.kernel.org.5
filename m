Return-Path: <linux-kernel+bounces-15263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D16822956
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF438284F18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE85182A2;
	Wed,  3 Jan 2024 08:10:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E58C18625;
	Wed,  3 Jan 2024 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DDF2C15;
	Wed,  3 Jan 2024 00:11:29 -0800 (PST)
Received: from [10.57.85.107] (unknown [10.57.85.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52BD33F5A1;
	Wed,  3 Jan 2024 00:10:42 -0800 (PST)
Message-ID: <b670b0bc-79ea-4be7-a78d-644b344be408@arm.com>
Date: Wed, 3 Jan 2024 08:11:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] thermal: netlink: Redefine the API and drop unused
 code
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <4556052.LvFx2qVVIh@kreacher>
 <CAJZ5v0hRGKjwDv0VLw550CLfUuNGaVXxmvcpbFhS=PCPqY0n4A@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hRGKjwDv0VLw550CLfUuNGaVXxmvcpbFhS=PCPqY0n4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 1/2/24 13:24, Rafael J. Wysocki wrote:
> On Fri, Dec 15, 2023 at 9:02 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> Hi Everyone,
>>
>> This patch series redefines the thermal netlink API to be somewhat more
>> convenient to use on the caller side and drops some unused code from
>> the thermal netlink library.
>>
>> Please refer to the individual patch changelogs for details.
> 
> No feedback, so this series doesn't appear to be controversial, and I
> would like to get it into 6.8.
> 
> Tentatively queuing it up and please let me know if it is problematic.
> 
> Thanks!
> 

I agree, these are not controversial patches, so IMO queuing them is OK.
I took a glance at them, but I can do the proper review today if you
like.

Regards,
Lukasz


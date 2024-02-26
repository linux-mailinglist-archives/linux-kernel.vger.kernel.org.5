Return-Path: <linux-kernel+bounces-82031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5B867DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F901F2C768
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAE612CD9F;
	Mon, 26 Feb 2024 17:12:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311AE12CD89;
	Mon, 26 Feb 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967555; cv=none; b=cqNYzohdW6HwjvNhmjPhgx3ry1W/P75NWsshaFZFO2EX0UTB/7GmjJpPOLOfWtVJVYwa4etM7PCbMfToaMLYBNb1ZsRPZz3jV7PbuVvmsVCyHAD0PkXadfU4DT9gdNh1SbnrLcc2CBcuCxJi4u0GaX5nqvA5aj/7L7YrNIov1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967555; c=relaxed/simple;
	bh=740ThXuH7qBFedfVnHgzd+yuT/T19dQtEhUBFyzKkaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTWRFi1xWquZuvOwCGJRV+8u1kn0r1N8BJoq87l7wt1/pP/7aGpTpYX7HFyh7P7UqH5EM1o6CC30TgTVaw0v5vOCxawH9N2vjcqJxZWs3YVWVWk1O/r+v5btI2D32NiIDm2wSVjAdKJHjXbXEze6glvbIOlL2SrgZmOtElBhKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36F68DA7;
	Mon, 26 Feb 2024 09:13:10 -0800 (PST)
Received: from [10.57.49.227] (unknown [10.57.49.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AA3A3F73F;
	Mon, 26 Feb 2024 09:12:30 -0800 (PST)
Message-ID: <3e1e7c18-d9ac-4f9a-82bb-6b4f10580705@arm.com>
Date: Mon, 26 Feb 2024 17:12:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Correcting the spelling mistakes in
 "Documentation/ABI/testing/sysfs-bus-cxl" and
 "Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc"
Content-Language: en-GB
To: prabhav kumar <pvkumar5749404@gmail.com>, mike.leach@linaro.org,
 james.clark@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 corbet@lwn.net, linux-doc@vger.kernel.org
References: <20240220214212.10231-1-pvkumar5749404@gmail.com>
 <CAH8oh8XcHGL_jdwLJJKa3qW0xQ6D36_LEUXFJUkzhdVNygSGjQ@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAH8oh8XcHGL_jdwLJJKa3qW0xQ6D36_LEUXFJUkzhdVNygSGjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/02/2024 18:52, prabhav kumar wrote:
> 
> 
> On Wed, Feb 21, 2024 at 3:12 AM Prabhav Kumar Vaish 
> <pvkumar5749404@gmail.com <mailto:pvkumar5749404@gmail.com>> wrote:
> 
>     Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com
>     <mailto:pvkumar5749404@gmail.com>>
> 
>     Changes:
>              - "avaialble" corrected to "available" in
>     "Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc"
>              - "firwmare" corrected to "firmware" in
>     "Documentation/ABI/testing/sysfs-bus-cxl"
>     Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com
>     <mailto:pvkumar5749404@gmail.com>>

And also, please don't post empty responses. + Fix your mail client to
stick to plain-text for email responses on the list.


Suzuki


>     ---
>       Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc | 2 +-
>       Documentation/ABI/testing/sysfs-bus-cxl                   | 2 +-
>       2 files changed, 2 insertions(+), 2 deletions(-)
> 
>     diff --git
>     a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>     b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>     index 96aafa66b4a5..339cec3b2f1a 100644
>     --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>     +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>     @@ -97,7 +97,7 @@ Date:         August 2023
>       KernelVersion: 6.7
>       Contact:       Anshuman Khandual <anshuman.khandual@arm.com
>     <mailto:anshuman.khandual@arm.com>>
>       Description:   (Read) Shows all supported Coresight TMC-ETR buffer
>     modes available
>     -               for the users to configure explicitly. This file is
>     avaialble only
>     +               for the users to configure explicitly. This file is
>     available only
>                      for TMC ETR devices.
> 
>       What:         
>     /sys/bus/coresight/devices/<memory_map>.tmc/buf_mode_preferred
>     diff --git a/Documentation/ABI/testing/sysfs-bus-cxl
>     b/Documentation/ABI/testing/sysfs-bus-cxl
>     index fff2581b8033..bbf6de5a4ca1 100644
>     --- a/Documentation/ABI/testing/sysfs-bus-cxl
>     +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>     @@ -224,7 +224,7 @@ Description:
>                      decoding a Host Physical Address range. Note that
>     this number
>                      may be elevated without any regionX objects active
>     or even
>                      enumerated, as this may be due to decoders
>     established by
>     -               platform firwmare or a previous kernel (kexec).
>     +               platform firmware or a previous kernel (kexec).
> 
> 
>       What:          /sys/bus/cxl/devices/decoderX.Y
>     -- 
>     2.34.1
> 



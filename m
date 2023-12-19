Return-Path: <linux-kernel+bounces-4548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F30817F22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B0B1C21F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E6F15B1;
	Tue, 19 Dec 2023 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="st0ab0jV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6611842;
	Tue, 19 Dec 2023 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id D92A4208A7FD; Mon, 18 Dec 2023 17:06:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D92A4208A7FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702947964;
	bh=GMHHzGcS/Ytec/qxgR+iiBTSKYqEcKrlbhU2V2sgIO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=st0ab0jVzCDXgShbY5NuVFsFglDcZr+ruGgPmnpYgBT+LA4s1+RFV/KQZFXmKfUx6
	 juLyazaygoZFe0EHtsettszjw+sbhxaKZCbbpWGZWxY33E9SoREQEHg8dk6KDwvhUp
	 JOwCMi+1URg0fr0SkV4HDNchWl4Nz4NDL7pF5AwA=
Date: Mon, 18 Dec 2023 17:06:04 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/106] 6.1.69-rc1 review
Message-ID: <20231219010604.GB15952@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20231218135055.005497074@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Dec 18, 2023 at 02:50:14PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.69 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you.

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 


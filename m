Return-Path: <linux-kernel+bounces-10592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F233B81D6B1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1D6283066
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 22:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1502518030;
	Sat, 23 Dec 2023 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="cKPYNOC5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C3171BE;
	Sat, 23 Dec 2023 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9CF6C4E5;
	Sat, 23 Dec 2023 22:07:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9CF6C4E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1703369256; bh=te8xA7fPnmxgfTKUkD9z2hLe9SkY4Miq3Ty/JOmHS2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cKPYNOC5FZSEtVG/gKjdD1Vh5El5UgTeTcU3U5gzMQFZ3/si3C7+mDhVk6u3m3W4a
	 n+GVPSibyBg5V4/Ji4LAfn9ZGx+lYyrJZ9GiHEe7joDE9x46gG83IAQHh0FktlfXEZ
	 ypmrfRCpxijlprJcnUKx+DgZYZuqWOc0YdtLJVMJsecvjXJI7etqq8zOpEylBkXuZT
	 uUZv86yMWgzIVQO2h8D226O3sVI50/2iCVHPL4YCbRujikussXHQx4v+qfn1CqmgXR
	 WPD9WfSR9RD4+2uybLa9SCrJR/eJJ+xXVePID5/IikujpxIePpFGb+SQcb0kJYXPFt
	 9x18yG3H38aYA==
From: Jonathan Corbet <corbet@lwn.net>
To: Tejun Heo <tj@kernel.org>, attreyee-muk <tintinm2017@gmail.com>
Cc: jiangshanlai@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/core-api : fix typo in workqueue
In-Reply-To: <ZYdSPGWlILYcTIKu@mtj.duckdns.org>
References: <20231223175316.24951-1-tintinm2017@gmail.com>
 <ZYdSPGWlILYcTIKu@mtj.duckdns.org>
Date: Sat, 23 Dec 2023 15:07:35 -0700
Message-ID: <87sf3s609k.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tejun Heo <tj@kernel.org> writes:

> Hello,
>
> On Sat, Dec 23, 2023 at 11:23:17PM +0530, attreyee-muk wrote:
>> Correct to =E2=80=9Cboundaries=E2=80=9D from =E2=80=9Cbounaries=E2=80=9D=
 in =E2=80=9CCPUs are grouped according to NUMA bounaries.=E2=80=9D
>>=20
>> Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Jonathan, would you mind taking this patch through doc tree? I don't have
> any other wq patches queued for 6.8 and it's a bit awkward to just apply
> this one.

Sure, will do.

jon


Return-Path: <linux-kernel+bounces-55294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8D984BA79
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D259F1F277D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16168134CC2;
	Tue,  6 Feb 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iy4Rf0E+"
Received: from out0-196.static.mail.aliyun.com (out0-196.static.mail.aliyun.com [59.82.0.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237471339AB
	for <linux-kernel+bounces-55024-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Tue,  6 Feb 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.82.0.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235288; cv=none; b=dWR7YXangT9q5bm6dS5Yjglj5HlKhOANObAUxeKcLpTHTOFBT2Az307BRdzrd2YWZyXOvZQhREHg+vF143BYcCxHr7xcHVV7bqbkfyNzp4fKR7hZSWrJ2GswK2DDh0lvB8u4KlW2vCOZOpRjALpPEYtk8SjwoMoIdH5lwXwrtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235288; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=HcjbGtCdGozO4QIBa+7SqnPxTs2GPwbMdz+XqQGnIGu/GYbnliDRDcFKTaPBPXUDXJWSwADf3JFtxKZB2Mu+sYkB8dvXvJBZDFFVwgqhj0ywxkz+M/HD+/GXmrm5fjZS9omyiA0/T7nNvjzVRd/O+Na2TlXgyMWKXPop9pE6Lk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iy4Rf0E+; arc=none smtp.client-ip=59.82.0.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707235278; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=iy4Rf0E+PU6KWrhglXa0Lg4QPl5z+vaHaT0Ulf7A+Po+7ysCMUeLn4zNSiIFUjcAdAr3UEwanOo5ew4Kuw2DPXZPxsybElpZKkwujDfLQKK74V6ppDEod+C7+4NQx0+ZOsN1NSsazyzi4AxU10OjJuhi22B5SE7qLhCRiWHvPTY=
auto-submitted:auto-replied
date:Wed, 07 Feb 2024 00:01:18 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6UmU6IFtQQVRDSCB2MiAwLzZdIFJlc3RvcmUgZGF0YSBsaWZldGltZSBzdXBwb3J0?=
to:linux-kernel@vger.kernel.org
message-id: 06eb830c-806d-477e-bd7c-cdeef9caa7e1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version:1.0
Content-Type:text/plain;
	charset="utf-8"

Hi, I'm on vacation. I'll get back to you when I'm done with this vacation.
I'll be back on 2.18.

Thanks.


Return-Path: <linux-kernel+bounces-52987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C552849F30
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284F0289AB2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29C34779F;
	Mon,  5 Feb 2024 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ln6XEdGk"
Received: from out0-179.static.mail.aliyun.com (out0-179.static.mail.aliyun.com [59.82.0.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D592C6B4
	for <linux-kernel+bounces-52968-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Mon,  5 Feb 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.82.0.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148832; cv=none; b=Em3v5Z2Rla/WpCXiDpCfXiKrBnVcmfxHw02NEVLQC1UanUt9Wr7emrSztkd5QzM3ek34myUr901FXw9TL2kRYMmeqF9zmKqKrD/JgTjUfVKo8rXsue9kTVNRO1tr5EsnnVGLqgzObv6iwFnBqFzpUN0RqjcIm1wWVoWMy27y84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148832; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=bYUQlDe0wlVNzBNtEHdrsTMP4lLL3POikT8sIIrmBrJ1h5Xcnzb4IsRX9rrbOWakl9tpw9gQi0QOPMXaD1KCmN221xPMYtZZj9KxisUpYeQnYEi3dBmobQOTRRb/VZw3ZVN28UNXBgJBjZVSVY/1yRjkCLJD4l2lyjGiQhiMNwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ln6XEdGk; arc=none smtp.client-ip=59.82.0.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707148827; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=Ln6XEdGkpnWwrDD05xXKe1RDwT5ld6oPWmusI9HiIixx1xOvuK4Ae6GA/1ZUSQzoB/zXQFK30izopNIBhYGXil6H1iSc2TwOd1lE7N5cDRHxbCD6qIAwTAfSpUNOBM4lMLNErybo+Yrm+XhxVafFa7fDfL7CpMfwSNsqrie/6u8=
auto-submitted:auto-replied
date:Tue, 06 Feb 2024 00:00:27 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6W1BBVENIIHYzIDA5LzIwXSBkcml2ZXJzOiBjcnlwdG86IG1lc29uOiBwcm9jZXNzIG1vcmUgdGhhbiBNQVhERVNDUyBkZXNjcmlwdG9ycw==?=
to:linux-kernel@vger.kernel.org
message-id: 3d4ac1d0-a94d-4a72-b71c-c6828b329f94
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


Return-Path: <linux-kernel+bounces-56745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F3284CE80
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AAC21C2215F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B7480056;
	Wed,  7 Feb 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C6fgJ8wG"
Received: from out199-24.us.a.mail.aliyun.com (out199-24.us.a.mail.aliyun.com [47.90.199.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A0880046
	for <linux-kernel+bounces-56744-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Wed,  7 Feb 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321660; cv=none; b=eQN3GYYLVfV1GRjEM0gRoVyuo+uE5kavdnczvCfxtBHMLtpId+YS88g2Fa+EoEvYdORtizMqRZgFGCcD4fx1GPx0rZWx/4HC/+6Dfm8x1eqoc10kvOZRCd5finZ8FL5i70shXMrfvkIdAHJ2s4DjEWqDUlCOP8S3PM5bG+QDINo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321660; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=V7R71je/vh4UFsgzhLsM1M/Q2GT+P+m+C0l5Gl7Kv8S2NbtLdLW7kWSEedV4Te3SsfImXRnUOL2c/UVKcsO1kEOW8OlnKPQIMEIBX0+wxxG7Ss4LpZsdwLfuar2mgVPW89zgnc4Osv4Wy8ZfyWrBxKnzmSxOqjQ2qJm6aJH5yzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C6fgJ8wG; arc=none smtp.client-ip=47.90.199.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707321639; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=C6fgJ8wGmmizWRE2mOVjhMwtEXgJ4LAYrjOYugQQCCS4PlHRe9qhg/49tXr0eAYKrc5rvweBmIXV2/pZyJpnkekJnDJM7Gg8rpMVXTO55w3Qv8x9EMjIL/agEWzJE1hPtybCX1kXTYOU3ZlPfudfA+3xo9Eso0HKz25U8wANb5Q=
auto-submitted:auto-replied
date:Thu, 08 Feb 2024 00:00:38 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6UmU6IFtQQVRDSCBwcmludGsgdjQgMDQvMTRdIHByaW50azogcmluZ2J1ZmZlcjogRG8gbm90IHNraXAgbm9uLWZpbmFsaXplZCByZWNvcmRzIHdpdGggcHJiX25leHRfc2VxKCk=?=
to:linux-kernel@vger.kernel.org
message-id: 17ffd99a-dbd8-4aab-b540-e653675838cb
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


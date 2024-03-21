Return-Path: <linux-kernel+bounces-110398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AAE885EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBC11F21416
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF2785650;
	Thu, 21 Mar 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxqR/9dc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38D12B7E;
	Thu, 21 Mar 2024 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039198; cv=none; b=cz2Ri7Ehjf8DpABQdPa+k7JG21NALLDgNqRyAgYsHJzh1GvybO0tL89/VoxXm+mTnI5rr9ehpmL4R3LTywGhaBLr/cJIKGA3qVBAyc7Z/n8xaqRbV5CohMoWHnyWU3AJVWfetFtQ/WAN7zpKB2Ahf3+vywdNSy918Fa6zDkU1c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039198; c=relaxed/simple;
	bh=cLa5z8Ewc33xpHSCUWMOo29kvXoVov6OLDGUdAEMZFE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hn85pDFkWEQNDjAk/+8BsVH+cVi/AB6rsWkqloW9C8HEaMInbn4KqhenUsPCvsApuZuTP7B2gH5eEjsn6zBGON7Ogfh7zVANodJIr6OuiMCBGAF1++kQqtNT7kGMgh/zjrbwdXdPOL/tDEIA8qowaHjpDTDzTfdzHiaWoInoxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxqR/9dc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3253C433F1;
	Thu, 21 Mar 2024 16:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711039198;
	bh=cLa5z8Ewc33xpHSCUWMOo29kvXoVov6OLDGUdAEMZFE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QxqR/9dc6P5uAshkly2kzfuhreh5+4fauNvXV1nLtrai+xoUm5pC8aZ2pVks7uigr
	 rnXq/clKVaSZ2Wfr61nDz4HpDkMUVmrJPUPUMiQejjNnl7ly2qwg3beq4ruuPpaNac
	 yfTRlaOMCLifI8BxFQA2W6D1P5U4401ugy81Hu1azWd4mmZo4UzppfIr34vQuZTPJD
	 H7KU/J70rU+NHTmuQQtZ16xLqxsF4dRpPmoEcGRihU/s0AdJ40+q7AVvfS4oK6XE0u
	 6TjTCe4ks+kOEhaUBSvxIAGYbu17AbqaXZEt2XAFoKIqlkNgZJ1RH4R9dnCgZ0G8pw
	 qqJCGxMac9j+Q==
Date: Thu, 21 Mar 2024 17:39:55 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Benjamin's email address
In-Reply-To: <20240321-bentiss_kernel-v1-1-eeaa04b4bfbc@kernel.org>
Message-ID: <nycvar.YFH.7.76.2403211738590.20263@cbobk.fhfr.pm>
References: <20240321-bentiss_kernel-v1-1-eeaa04b4bfbc@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 21 Mar 2024, Benjamin Tissoires wrote:

> Update my email address to the kernel.org one, as it's getting
> more convenient this way.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Appplied to hid.git#for-6.9/upstream-fixes.

> ---
> Basically it's getting easier for me to use the kernel.org address
> instead of my company's one. So let's do it.
> 
> Note sure if I should go through the whole tree to change the different
> occurences of my email, but worse case this can happen in a separate
> patch.

That's exactly why I prefer not to put e-mail address in copyright headers 
at all in the first place :)

-- 
Jiri Kosina
SUSE Labs



Return-Path: <linux-kernel+bounces-9511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1234981C6BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76738284A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCD3CA59;
	Fri, 22 Dec 2023 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k0/8kl6L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wnqAmtK/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD3C13B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Dec 2023 09:40:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703234408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0WxyedAa2P1K2XYcDKTzSWwYOWigDCvSrcqh62UUEk=;
	b=k0/8kl6LkfxIlbvxwXThnVATHfiZP9GArFiARFWer3k0pTSMsGM8hbBC0NRbmn+4GiFGMH
	eyZdz11sVPj9hsAXD0MHWUpGD4YUTOEFeHqPPQlwfvz9U1OaFnSxOrNGwvv0eZnwsbwSuw
	LmuIE0K/IWV9P6rnzkcQq3i6N/3NdbsZQ9MDAqS3ejPqEQ4kndMJFTq8KdHQbwT8UbCUwa
	BVK3Kf3RyH5aW4sevJcxhYWoO8vDaXVfl6xmAmARFL0H/I50oeD29FRiwqNVlD3zEDkwg8
	iXH3HzWd7YYb7uJM4/WgOibyVyljZXPPUYZ6yVnH8J2HQcMIKbBMM+btsLeRwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703234408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0WxyedAa2P1K2XYcDKTzSWwYOWigDCvSrcqh62UUEk=;
	b=wnqAmtK/0mXOzk1iQMpCsYtUC8f9kOJTT6qHjaDxpIwymuD5SZS/jiv+3S7F/WsFVhxipL
	Bjv+zpDBVWilpPCQ==
From: Nam Cao <namcao@linutronix.de>
To: Ryan England <rcengland@gmail.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Florian Schilhabel
 <florian.c.schilhabel@googlemail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8712: fix open parentheses alignment
Message-ID: <20231222094007.2e60731f@namcao>
In-Reply-To: <ZYSemFbzTlgLROMc@kernel.ryanengland.xyz>
References: <ZYSemFbzTlgLROMc@kernel.ryanengland.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 20:22:48 +0000 Ryan England <rcengland@gmail.com> wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Ryan England <rcengland@gmail.com>

You already sent a v2 in the past, so this one should be v3.

Best regards,
Nam



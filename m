Return-Path: <linux-kernel+bounces-9521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE3681C6ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA542820D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2533BD51E;
	Fri, 22 Dec 2023 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PnjnlHLJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FzsUqX4Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56185D2E0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Dec 2023 09:56:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703235373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3redX9Xkb6f0sXtn4IBQJXwcECuz/h2jAN8Zswb/Ak=;
	b=PnjnlHLJS6BBdtyryRr/PESPeARtK9TKgadyPwiff1nyuxYRHeeRvnNycFp3pdCz3Vq7bt
	A+pjmFHm3hlstqHjIWbAvIEtNuAJpfoCEPv13zpPOpGcZACU/YE+TyzdgPLkQA5lsXPocQ
	HvGowIbPyZ65UpATcdH/Q8Yd3f7/t41DuErWE9haWY2/pnf8l0Y0Z2KzAxBpDwLqcf5NWT
	gLA9rlKBsc1aCs0vh48ZzmHWaG3xEqV9MpA6SrwbolFFJnOtBYe/eB9MkRx7zAfjD++2pF
	0nr90cVDoBfeD0E7L4P3QpbJrfO3ET76/Y2SEPnTSa+4wZ7x5dDKUnoKZDiqsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703235373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3redX9Xkb6f0sXtn4IBQJXwcECuz/h2jAN8Zswb/Ak=;
	b=FzsUqX4Z+qibIbYvppdc02MM06srn1Bxl/rDU3yXthxvPk6NizoMPxh97jnE+JbZhARklz
	pO5lmx3IBubVL5AA==
From: Nam Cao <namcao@linutronix.de>
To: Ryan England <rcengland@gmail.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Florian Schilhabel
 <florian.c.schilhabel@googlemail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8712: fix open parentheses alignment
Message-ID: <20231222095612.589463ef@namcao>
In-Reply-To: <20231222095259.75f145cf@namcao>
References: <ZYSemFbzTlgLROMc@kernel.ryanengland.xyz>
	<20231222095259.75f145cf@namcao>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 09:52:59 +0100 Nam Cao <namcao@linutronix.de> wrote:
> Note that, because you CAN you 100 characters, does not mean you MUST use 100
> characters.

I don't know why I wrote it this way. What I meant to say is that it is
probably not worth it to change the code only to make sure they use all 100
characters.

Best regards,
Nam


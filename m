Return-Path: <linux-kernel+bounces-173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06D8813D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9911C21CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED3767201;
	Thu, 14 Dec 2023 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A1+RQwOX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4494671F3;
	Thu, 14 Dec 2023 22:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FFFC433C7;
	Thu, 14 Dec 2023 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702591725;
	bh=dIxLbjEbVbXphoL5KtuoBPtemCI18U91ubGJgc6Ql0Y=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=A1+RQwOXqmvEw/JcHCQOQ0wIPS9o/KTGuTJiUoDjaf4iq4LyylOY1xJQp5m9tVjDL
	 0MXz9Hcw5XH4telbiuP7SP65CsxGuKJS0gEmsq2c8NFAfjz8415z97nHNAtSvPA/d0
	 knCzOE/FNXi/5qIA5vnZIMYPKo2Xagvv6xG2JuPI=
Date: Thu, 14 Dec 2023 17:08:44 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: users@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PSA: final vger mailing list migration: Thu, Dec 14, 11AM PST
 (1900 UTC)
Message-ID: <20231214-unbiased-modest-herring-12b6eb@meerkat>
References: <20231212-unselfish-real-myna-67e444@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212-unselfish-real-myna-67e444@lemur>

On Tue, Dec 12, 2023 at 04:36:28PM -0500, Konstantin Ryabitsev wrote:
> This Thursday, December 14, at 11AM Pacific (19:00 UTC), we will switch the MX
> record for vger to point to the new location (subspace.kernel.org), which will
> complete the mailing list migration from the legacy vger server to the new
> infrastructure.

This work is completed, but there will be a brief outage around 3PM PST (23:00
UTC) to bump the number of CPUs needed for all the increased spam scanning.

-K


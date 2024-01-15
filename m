Return-Path: <linux-kernel+bounces-25938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5747182D88D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0211F222FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198332C695;
	Mon, 15 Jan 2024 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="aDTtuP1+"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7B2C689
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail3; t=1705319210; x=1705578410;
	bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aDTtuP1+iQeUlBHoSI9w0f+MIxjTRwixtOoPE7Gxu7ElQWKf7z+oltvhohON9sSyC
	 QLrl8sVeUJ0zAsI/udr8ylclIZqoxTS/+ZMHTpgk/tFcc0ovG4h272JAnDgq5jVF6O
	 ayqFNGUg4U3wfagp1XTarEKXmFyhrIfrGv9JLlAXeS9KKU9Riq49MYIRHN3YMB14TR
	 KM7fRutyxVvscAGoKQtYB+QIHl9ymj47TnI8lV7k/lgO3GAVJ9JkdFVBDWeWVEWnr4
	 oyP+KM5e+LU3kswUzhKmBdeijdUq/IIOrtKvXvfowc11L/D0yYPHtR3uBaZZIf8y7C
	 sOlD17Zx7aceg==
Date: Mon, 15 Jan 2024 11:46:37 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>
From: Simon Ser <contact@emersion.fr>
Cc: daniel@ffwll.ch, airlied@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/gpu: Reference articles on Linux graphics stack
Message-ID: <5TmDVDH1oAzfjHBIixotJqZi2HCO96yZWVoxOMxJzN2WjPAqQ_sH8Ze7o81bncRk9FuUuzp4kpZXmQJpcA9M60bvFC2rzCjTMzeDRGndews=@emersion.fr>
In-Reply-To: <20240115113908.25897-1-tzimmermann@suse.de>
References: <20240115113908.25897-1-tzimmermann@suse.de>
Feedback-ID: 1358184:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Simon Ser <contact@emersion.fr>


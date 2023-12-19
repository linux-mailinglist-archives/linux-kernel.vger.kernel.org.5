Return-Path: <linux-kernel+bounces-4665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB346818067
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3C8B2211B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13F36AA2;
	Tue, 19 Dec 2023 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hacsjPYR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0BFC123;
	Tue, 19 Dec 2023 04:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2D9C433C8;
	Tue, 19 Dec 2023 04:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702959136;
	bh=A0o8Cis9GBjzQ0hNF1DI0Tm54wJQapdqNKfZp687fdk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=hacsjPYRpmQLBdQOHlxQAhBoakr18Tg1A9SQdR0eslFvVCCTZhZvnUQ+viZu4ZlxR
	 cK2E4QSJ25vU8CaSE5T/cdC1z5kTUKLA3OHDQxIP+Q2VQwH3MTkKr7wY8MxsskA+4V
	 VcNrOXf/P1pEU2DQ7OlVVkjZnLsAHZUlIjd518cV84s4rklM5hvvemh4lBl7/84+Q4
	 cUT40z76A29opWk44inb+v+2bvYsqUiCMKX99PrmuD18KlmQhCj8Enl32QgcGRbUmZ
	 Mscg/c06Ya0TKESklv9QUuqwRD+U5sHoLlpr2X0zZgKH57PUEgMAY9H/nrR5Fu9m4M
	 rR6U8SW0+2nNA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: MAINTAINERS: wifi: brcm80211: remove non-existing
 SHA-cyfmac-dev-list@infineon.com
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231218121105.23882-1-lukas.bulwahn@gmail.com>
References: <20231218121105.23882-1-lukas.bulwahn@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Arend van Spriel <aspriel@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170295913267.640718.8284035097366475252.kvalo@kernel.org>
Date: Tue, 19 Dec 2023 04:12:14 +0000 (UTC)

Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> When sending an email to SHA-cyfmac-dev-list@infineon.com, the server
> responds '550 #5.1.0 Address rejected.'
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Patch applied to wireless.git, thanks.

044879ce5406 MAINTAINERS: wifi: brcm80211: remove non-existing SHA-cyfmac-dev-list@infineon.com

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231218121105.23882-1-lukas.bulwahn@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches



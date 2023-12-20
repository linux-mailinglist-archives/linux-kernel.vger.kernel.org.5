Return-Path: <linux-kernel+bounces-7188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9BE81A2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630361F22FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1D14175F;
	Wed, 20 Dec 2023 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AVC49m9F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D984174A;
	Wed, 20 Dec 2023 15:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC20AC433C7;
	Wed, 20 Dec 2023 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703087196;
	bh=msAgnUJbaRwfm0a89d9Fghf3puPMYUbmDNZfg/0kRDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AVC49m9FN7UGqMos9JDgfGONK9pW0mV8N1W5Vv3mUk6F8twDEkxVRjNuBW5IX5JUG
	 0nLJsru7WPnunGTjb8v+22r3+58p8Imo1VC0eV03PaX/vc6dYu8/ZTuhs9iN6RDN2k
	 DT9h9/+GrpK5JBrs2or6PwZlDKEuYDvIQ3LPCpIY=
Date: Wed, 20 Dec 2023 07:46:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
 joe@perches.com, nathan@kernel.org
Subject: Re: [PATCH v4 5/7] kexec_file, ricv: print out debugging message if
 required
Message-Id: <20231220074634.cd736ec567cd7adf1e4c6d7e@linux-foundation.org>
In-Reply-To: <ZYJsBW0Y7Y+XhSgf@MiWiFi-R3L-srv>
References: <20231213055747.61826-1-bhe@redhat.com>
	<20231213055747.61826-6-bhe@redhat.com>
	<20231219-twitch-many-ca8877857182@spud>
	<ZYJsBW0Y7Y+XhSgf@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 12:22:29 +0800 Baoquan He <bhe@redhat.com> wrote:

> Could you help fix the typo in subject?
> 
> [PATCH v4 5/7] kexec_file, ricv: print out debugging message if required
>                            ~~~ s/ricv/riscv/

I made that change.


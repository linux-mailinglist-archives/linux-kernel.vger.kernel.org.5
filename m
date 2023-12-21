Return-Path: <linux-kernel+bounces-8225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDFE81B3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF161C213CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BA474E15;
	Thu, 21 Dec 2023 10:40:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E76EB63
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swn5Y4NDZz4xMv;
	Thu, 21 Dec 2023 21:40:49 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, christophe.leroy@csgroup.eu, robh@kernel.org, Kunwu Chan <chentao@kylinos.cn>
Cc: kunwu.chan@hotmail.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231126095739.1501990-1-chentao@kylinos.cn>
References: <20231126095739.1501990-1-chentao@kylinos.cn>
Subject: Re: [PATCH] powerpc/powernv: Fix null pointer dereference in opal_powercap_init
Message-Id: <170315510017.2192823.14859661011576735714.b4-ty@ellerman.id.au>
Date: Thu, 21 Dec 2023 21:38:20 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, 26 Nov 2023 17:57:39 +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/powernv: Fix null pointer dereference in opal_powercap_init
      https://git.kernel.org/powerpc/c/e123015c0ba859cf48aa7f89c5016cc6e98e018d

cheers


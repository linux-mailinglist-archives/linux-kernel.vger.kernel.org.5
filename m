Return-Path: <linux-kernel+bounces-13691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A730E820B35
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 12:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B00CB212CB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C607568B;
	Sun, 31 Dec 2023 11:08:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D533CF
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T2xDl4xm1z4x3G;
	Sun, 31 Dec 2023 22:08:23 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, Haoran Liu <liuhaoran14@163.com>
Cc: christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231127144108.29782-1-liuhaoran14@163.com>
References: <20231127144108.29782-1-liuhaoran14@163.com>
Subject: Re: [PATCH] powerpc/powernv: Add error handling to opal_prd_range_is_valid
Message-Id: <170402086356.3311386.1240109605547008356.b4-ty@ellerman.id.au>
Date: Sun, 31 Dec 2023 22:07:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 06:41:08 -0800, Haoran Liu wrote:
> In the opal_prd_range_is_valid function within opal-prd.c,
> error handling was missing for the of_get_address call.
> This patch adds necessary error checking, ensuring that the
> function gracefully handles scenarios where of_get_address fails.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/powernv: Add error handling to opal_prd_range_is_valid
      https://git.kernel.org/powerpc/c/e6beb47edb89ca9dc8906515e2dfbeb5913312c8

cheers


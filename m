Return-Path: <linux-kernel+bounces-167528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475828BAAE6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F0B1C21E37
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868002135B;
	Fri,  3 May 2024 10:42:32 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428A1514D0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732952; cv=none; b=NA/TkoLmWEuwAXBdlb0zf5Oocm0ArBCVlxoXjE9vc65xWNwG4gWPCgcpwvlpfHrIRpuIQw+2vQpKRSmOuH6OZLCRMRl0ynGqvjh/jFnPZdqftxI+oeGmL6sMBMBYtleF+DvZ8gdQcJBJ9Ne7icHbsCW34ThG7QhdTtAvS7yWHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732952; c=relaxed/simple;
	bh=8IIAYTSWr27ti9myRuuA99XOWAvpj9lv2MelmDilSSw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FqfFLUXYmPgEDKkZVcxd1NbxuqwUacS2CczMnR3XUF9LW1WnHCL6L7CAGB9RJYVpeMuXBJQrg6blkuutThUTI/pMfO44ZvoG1JIRwuETnUDCISfgazM4AJurRz4lYbvCYeduu3iDO38sOFDXAICXdn7E/lSJ7EUiV4b3wqh6rsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW6nc74c9z4xGl;
	Fri,  3 May 2024 20:42:28 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@kernel.org, will@kernel.org
In-Reply-To: <20240430044327.49363-1-mpe@ellerman.id.au>
References: <20240430044327.49363-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] MAINTAINERS: MMU GATHER: Update Aneesh's address
Message-Id: <171473286296.451432.716496319296751388.b4-ty@ellerman.id.au>
Date: Fri, 03 May 2024 20:41:02 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 14:43:27 +1000, Michael Ellerman wrote:
> Aneesh's IBM address no longer works, switch to his preferred kernel.org
> address.
> 
> 

Applied to powerpc/next.

[1/1] MAINTAINERS: MMU GATHER: Update Aneesh's address
      https://git.kernel.org/powerpc/c/1fcd254733371cfa5a3602bab5ae2c9dc4bf69e6

cheers


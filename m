Return-Path: <linux-kernel+bounces-167529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC168BAAE7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C4A1F21D28
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1808D152179;
	Fri,  3 May 2024 10:42:33 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59C7E766
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732952; cv=none; b=mTkuO/MtgBoyuhHnvOUvC/Z8MpQmt/+PlFqRam09C+HUDUwsHqoKb0FAM+13t4Ba17geUwEaRco52ljEbslz98TUM6nh2+lTJ7ffGWyq+9yhDgHZfgN6cpJqUAvd5KQENMEHYMCEBI0HWG4vbCdn2LO6mOqS4ZmXjsp581ReRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732952; c=relaxed/simple;
	bh=Pxdsjs2OnvNlr6FzD0wrjwJa8tPUZz+jGSTHaxC5mIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ibgw+Bc/EkTz5T0w7mQ8iIlAb6/jz3jHjlQemdVnOmpmHOlWrMpPV8MjIWQicZWQCLq+ZW3kSq/O7RtqJ44XwZSxqdrBUzHrKCcsE49BvkhywDChB7ECM6MTkSeQ1Kye83/L22du80I8OAwAX876TEmkxnqvf8kVB5XtwnBqyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW6nd3J3Lz4xM1;
	Fri,  3 May 2024 20:42:29 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: npiggin@gmail.com, naveen.n.rao@linux.ibm.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240430044228.49015-1-mpe@ellerman.id.au>
References: <20240430044228.49015-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] MAINTAINERS: powerpc: Remove Aneesh
Message-Id: <171473286295.451432.18028419480406369786.b4-ty@ellerman.id.au>
Date: Fri, 03 May 2024 20:41:02 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 14:42:28 +1000, Michael Ellerman wrote:
> Aneesh is stepping down from powerpc maintenance.
> 
> 

Applied to powerpc/next.

[1/1] MAINTAINERS: powerpc: Remove Aneesh
      https://git.kernel.org/powerpc/c/6a3e640b5dcf56fb44d66d525e01ea08633c6b8b

cheers


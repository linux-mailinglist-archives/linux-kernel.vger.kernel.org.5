Return-Path: <linux-kernel+bounces-24186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF9182B8B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90267282C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2264C10FE;
	Fri, 12 Jan 2024 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsXk11xq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F17B812;
	Fri, 12 Jan 2024 00:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE17C433F1;
	Fri, 12 Jan 2024 00:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705020256;
	bh=+ieIg1Vyrm7V4Kx0AWUkiM3IfDgk/8hVTKmTn+rXIUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hsXk11xqgvlvqBCv3MXy+6XQzo99gGTJPlboJrXI4F5CZcLU+MqenfuD6HXXX4JCS
	 KrLch1AcWdOvv3HkjZ+gkGtjUjFSgC9vKxVVClVoCTxCCXYPY7HZr6v9JTjDKH9IMC
	 hzaUd49PCUL3lIqCdlMSRRB0XgqzaKsbKEgKoWWSf3Xx9G9a8R5nR3joQqfrp0aUTU
	 OzubsdpCx5XxFl9HYLG0q7ElB4kIFsQMT4LAexZE3yk67qj/CpHv3bTdl1R8t881xX
	 scSeFGg6HBc3U1lj2/Ujz+p3TUvWxIM4xBdKGHVdivN5acqSsmXgNV0brz4A0MIDFF
	 k5M+5WEHIK5/w==
Date: Thu, 11 Jan 2024 16:44:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aahil Awatramani <aahila@google.com>
Cc: David Dillow <dave@thedillows.org>, Mahesh Bandewar
 <maheshb@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Martin
 KaFai Lau <martin.lau@kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] bonding: Add independent control state
 machine
Message-ID: <20240111164414.58c7af7d@kernel.org>
In-Reply-To: <20240111203244.1712804-1-aahila@google.com>
References: <20240111203244.1712804-1-aahila@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jan 2024 20:32:43 +0000 Aahil Awatramani wrote:
> Add support for the independent control state machine per IEEE
> 802.1AX-2008 5.4.15 in addition to the existing implementation of the
> coupled control state machine.

## Form letter - net-next-closed

The merge window for v6.8 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after January 22nd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer



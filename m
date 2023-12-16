Return-Path: <linux-kernel+bounces-2092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76548157C7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EE91C23EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC14125B4;
	Sat, 16 Dec 2023 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fgYkPawO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE8111AD;
	Sat, 16 Dec 2023 05:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=wW4Yr1j3Xjr3ELqasnlv6abKiScSYHekVUbrVNiM2do=; b=fgYkPawOO6vapgYqH/LTT/h2Tr
	/dFT6M0WdGx6aWG3VgLqaqkeZgZ+MHxXkGR9jTP5DQZkUckdOG9NOerUJCMBVzSViXMEFuHGQTLB0
	zDqM5/WEEzUYmCa2VKge05V7d5eRRWT7GBTXZT+ZHKvjk7JxshFyTNjblJ1QwI5jL+CV1ncNmpRnk
	JtbS8E/KMNmMHkRaTswX4RbuJsTWxZ7KUBB7Y8emaKRG0uBeQkTQQElFLd69TYlTUZd8kcCp2HYz+
	5O0NSWD/48RNOAFFvHOQK7GKOjAaRMWYg5cuGBeZCGl7RbDhPoET+bkpIrhXOVWgDfM7IOrKhXtXR
	KzekLM5w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rENEy-005U7r-0e;
	Sat, 16 Dec 2023 05:29:32 +0000
Message-ID: <8a078303-f52b-4e3c-91da-315556e3738e@infradead.org>
Date: Fri, 15 Dec 2023 21:29:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Dec 15 (fs/afs/)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>
References: <20231215150128.07763fb1@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231215150128.07763fb1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/14/23 20:01, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20231214:
> 

on i386:


-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html


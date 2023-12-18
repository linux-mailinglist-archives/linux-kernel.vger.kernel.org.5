Return-Path: <linux-kernel+bounces-3937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD42817547
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DFA28228A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312EA42370;
	Mon, 18 Dec 2023 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FrVftBXk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0183D546;
	Mon, 18 Dec 2023 15:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D864C433C7;
	Mon, 18 Dec 2023 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702913578;
	bh=0arEW90zEE9OhkEw7bJG6PQPq3nVictsKaUcuXWUeX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrVftBXkWiuvY0q1HiFZbbUrX9D4AZV1GcKoRSzbk2lQuOBXH3lDGQMtKX+Xn86tC
	 4O1LljzPU5ABk9r1KwTnB7pnPvMSXXOfeDVLU03nxjkRi3waVgg+5rEhEtjWNPIK6u
	 fkfJBN0sfKc48ZG8MCfkZfHbttjMixqkXLDYIvFc=
Date: Mon, 18 Dec 2023 16:32:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Staging: rtl8192e: Rename 6 variables to Style guide
 spec
Message-ID: <2023121821-gracious-maternity-9651@gregkh>
References: <20231217235520.30377-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217235520.30377-1-tdavies@darkphysics.net>

On Sun, Dec 17, 2023 at 03:55:14PM -0800, Tree Davies wrote:
> This patch set renames variable to fix checkpatch warnings

Not all applied, please rebase and resend the remaining ones.

thanks,

greg k-h


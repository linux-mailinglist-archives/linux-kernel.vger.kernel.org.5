Return-Path: <linux-kernel+bounces-25322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CFC82CD7D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D2C283C29
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F41FBB;
	Sat, 13 Jan 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2lTsrhz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73F23A3;
	Sat, 13 Jan 2024 15:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441A6C433C7;
	Sat, 13 Jan 2024 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705159878;
	bh=Qfs2cj7JCte0gKHDzV5NLUlHh1kvgCNmTYtxJZN4Udo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q2lTsrhz19T9Qzi32wC8wO2nmB4DPfrFdByFTjnPFx5TB3OvNG9IP23ZfZR1EytTi
	 7xo+o7UWigD8GN3cfrDiPVX8p7nNxpnN0KY3eI9VowCwJC987LpdfuU7+/DTnev4LF
	 pvBHaMcT+t3BrKvl0Q10TtC2vcGJ/qxegUxtXd6V9JEgwEsMK8vbmRHTHm9M/DbPlk
	 eDQzovLgNfgtyBUmA8yfY2rgjaNYpRRcBZEa3Lfesnhe5QPln/i4aqVJGPgKDcWfqu
	 PejJKnQ6Eh8DivbnwxK0X4I/Ld5YSzcf7Z5kVHbBTuuz9ro+dvprwrbBQeSmLPoGm9
	 8Sr6OJS4qn8dA==
Date: Sat, 13 Jan 2024 15:31:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <cy_huang@richtek.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] RTQ6056: Add compatible for the same chip family
Message-ID: <20240113153112.42d3b978@jic23-huawei>
In-Reply-To: <cover.1704676198.git.cy_huang@richtek.com>
References: <cover.1704676198.git.cy_huang@richtek.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jan 2024 09:47:26 +0800
<cy_huang@richtek.com> wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>

Applied to the togreg branch of iio.git but for now only pushed out as testing
as I will be rebasing my tree on rc1 once it is available.

Thanks,

Jonathan


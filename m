Return-Path: <linux-kernel+bounces-8579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B642481B9B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3143E285412
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA8D1D6BD;
	Thu, 21 Dec 2023 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pACkWHtc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218BBEDC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A0CC433C7;
	Thu, 21 Dec 2023 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703169635;
	bh=BQum2Pu1iU2MfE3l/A9uSN7XdYuuMtnSrftnoZMFHms=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pACkWHtcHYNUCVbfS/Qexd6DvWVLlk/EjMfzJTH2qh9RH9I2CAcYSPFE4YFay/0O/
	 e91tvACui+JgGyP5c2Fq8/NZyXFD+u9xGb4ZmWd7/Lon3nxFeZZ1cCYhiTyO9doPVG
	 LyGOZZbb2Ht5yUwfxf+4X9Kd5CwCc0WpSlG8oXQhO+4IbCmqLYd5jkBYYWcczV9OFa
	 AG/P3w2OrSJkeL8EPO73HYd+sheifFisjDy77cDsgdK+GOZTSoiCcDAJ0SXuHPIY27
	 weATTXtl2F5XFE7OirpOoL7XjMatHFJhEFgZvKd2GagqckC5I11JiOxiHX7ciklEZ0
	 ekmz5byg1HuZA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231214-ab8500-sysctrl-oneliner-v1-1-fd78a15c0b2f@linaro.org>
References: <20231214-ab8500-sysctrl-oneliner-v1-1-fd78a15c0b2f@linaro.org>
Subject: Re: (subset) [PATCH] mfd: ab8500-sysctrl: Drop ancient charger
Message-Id: <170316963447.599575.18294304575878441440.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 14:40:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Thu, 14 Dec 2023 19:26:31 +0100, Linus Walleij wrote:
> The sysctrl driver was looking for an instance of the PM2301
> charger but this has been deleted from the kernel and is not
> used with the U8500 systems any more. Drop the string.
> 
> 

Applied, thanks!

[1/1] mfd: ab8500-sysctrl: Drop ancient charger
      commit: 9aab3f5b572eca8f4f2c3ffbbf4aeecf7d5cadb9

--
Lee Jones [李琼斯]



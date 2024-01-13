Return-Path: <linux-kernel+bounces-25320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A02382CD75
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE70B22A11
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820591FA4;
	Sat, 13 Jan 2024 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKxP9PGh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99ABEBB;
	Sat, 13 Jan 2024 15:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8947CC433F1;
	Sat, 13 Jan 2024 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705159481;
	bh=jJeLWP4ejFcpTY2q0vK4zybD2k1TQBBebMHLIBPNFtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tKxP9PGhMWPZ2SVmtn/rUHfmvA+K0PRlMjGlxz5fSi2cKgd63SHhuo4sVi8LPeb+q
	 qEsFYti1IqL8ukqDAfoG00l/9NknWM38JA/thAh2hL4c+RVd1zligBElPSwaxhFcBG
	 ODmDAdDEfIJbIIjWbMvF78Zmy4qlwn4tXvr6lElgykcOzC91nB/SIAqoYDduzzUQSJ
	 66EO1AaoBQjGQ+sW+lB7CE+tCqqV06vxQEndHNICCkKtDOjcw4mpDjZbRZfxALRizc
	 a4garEe4yKkb87AgdXBgsxe0knGY6zPSGq7uiDkOMVzHJn8psjyVVD6KOZ6EfiBwpX
	 jDD/3SvQbv8/g==
Date: Sat, 13 Jan 2024 15:24:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: correct file entry in ANALOG DEVICES INC
 AD7091R DRIVER
Message-ID: <20240113152435.751f5858@jic23-huawei>
In-Reply-To: <20240108094320.31296-1-lukas.bulwahn@gmail.com>
References: <20240108094320.31296-1-lukas.bulwahn@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jan 2024 10:43:20 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit de35d4092681 ("MAINTAINERS: Add MAINTAINERS entry for AD7091R") adds
> the section ANALOG DEVICES INC AD7091R DRIVER in MAINTAINERS, but gets the
> file entry for its driver wrong by duplicating the intended path.
> 
> Correct the file entry to the actual path for this driver.
> 
> Fixes: de35d4092681 ("MAINTAINERS: Add MAINTAINERS entry for AD7091R")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Thanks Lukas,

Alternative fix was already posted. Note the discussion about fixes tags
for MAINTAINERS entries.. 
https://patchwork.kernel.org/project/linux-iio/patch/CAO=gReEUr4B+E2mQsSrncHf41f0A915SuoWgA522_2Ts-dZbSg@mail.gmail.com/
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1bf5637bd1f9..23d19b2a7ae3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1137,7 +1137,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	http://ez.analog.com/community/linux-device-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
> -F:	drivers/iio/adc/drivers/iio/adc/ad7091r*
> +F:	drivers/iio/adc/ad7091r*
>  
>  ANALOG DEVICES INC AD7192 DRIVER
>  M:	Alexandru Tachici <alexandru.tachici@analog.com>



Return-Path: <linux-kernel+bounces-4996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1B48184FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321AC1C23550
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71A014271;
	Tue, 19 Dec 2023 10:06:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301D14267
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (82-72-63-87.cable.dynamic.v4.ziggo.nl [82.72.63.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6D30420091;
	Tue, 19 Dec 2023 11:06:10 +0100 (CET)
Date: Tue, 19 Dec 2023 11:06:08 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, phone-devel@vger.kernel.org, 
	Pavel Machek <pavel@ucw.cz>, Bjorn Andersson <bjorn.andersson@linaro.org>, 
	~postmarketos/upstreaming@lists.sr.ht, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, Konrad Dybcio <konrad.dybcio@somainline.org>, 
	Martin Botka <martin.botka@somainline.org>, Jami Kettunen <jami.kettunen@somainline.org>, 
	linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>, 
	Satya Priya <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH v4 2/2] leds: qcom-lpg: Add PM660L configuration and
 compatible
Message-ID: <xkmmbgbg2japfunuure2kktbxdkotteawwgzsjq6giafmwuosz@3no7qov5nzei>
References: <20220719211848.1653920-1-marijn.suijten@somainline.org>
 <20220719211848.1653920-2-marijn.suijten@somainline.org>
 <ZYFS04cznE5bhOeV@hovoldconsulting.com>
 <3lsapoxlqijes5m4nqcbhdfhhs4chq3mcq3jaty7v2zihsqnwu@nn67a4h6425k>
 <ZYFjZefdJej_vgwD@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYFjZefdJej_vgwD@hovoldconsulting.com>

On 2023-12-19 10:33:25, Johan Hovold wrote:
> On Tue, Dec 19, 2023 at 10:17:16AM +0100, Marijn Suijten wrote:
> 
> > Note that I have one more unmerged leds patch around, that hasn't been looked
> > at either.  Would it help to send this once again, perhaps with more reviewers/
> > testing (Johan, would you mind taking a look too)?
> > 
> > https://lore.kernel.org/linux-leds/20220719213034.1664056-1-marijn.suijten@somainline.org/
> 
> Yes, I suggest you resend that one too so that it ends up in Lee's
> inbox.

I will rebase, test and resend it too.  Just asking if you notice any glaring
issues with this patch, as it won't be the first time it has been resent after
not being looked at for some time.

- Marijn


Return-Path: <linux-kernel+bounces-14312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690EA821B36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DCA2831BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D67EAF6;
	Tue,  2 Jan 2024 11:51:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED49EAC5;
	Tue,  2 Jan 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-556ab8b85e3so150395a12.1;
        Tue, 02 Jan 2024 03:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704196298; x=1704801098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adTWx/k62Y91HsuyX07Wlly10Dmf3/XSYSsNAhC+0/U=;
        b=qacc61Gl+1cFvsIYzdEqprrfDBi0h3ahy+HVaa68fUvyJpuJOa4YEmY6kV9jzVh4Ij
         Qpcvoq5iS6/PIUaKoebZzSv9SbfiZtbr+4i6VnLItrnu8qZF93warpcgGxbRzDiWa9Df
         8gxmGIM0ZrwTHOTCDZPWIh7hAIv0quJ6Cps4Qgtgc40HP7v7HGTJYYh85xyOp6y+uXXY
         OvYg4K5q9IF1sZ8+tyJ5SFUaNYtEh0F4Z2ZmILx/+P3RB8hAsZp5DM8BXAyiqKwnzXGF
         eAD55MZGhEakSBZ69/7BJg+n7pdgk/359f3np2cIgNvfzujvdfSI+p6G6dIhEGTLTnPS
         fnVw==
X-Gm-Message-State: AOJu0YxDo0+QZLEPVb2el76IqClyaZdiUW+o0VTjmlLhy3uaAho1sL7J
	9TG0gCOy6Tc/qwSbcj2PwS8=
X-Google-Smtp-Source: AGHT+IFiHnZQw5f9kufoiu227wpzclOWRnjx7lrgamOWqUaVv2Z7fhZNctIWtYPNIEARRU0kbFocpw==
X-Received: by 2002:a50:c042:0:b0:555:9bd7:a4f0 with SMTP id u2-20020a50c042000000b005559bd7a4f0mr7800834edd.36.1704196298081;
        Tue, 02 Jan 2024 03:51:38 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-002.fbsv.net. [2a03:2880:31ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id u18-20020aa7db92000000b00554d6b46a3dsm11058289edt.46.2024.01.02.03.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 03:51:37 -0800 (PST)
Date: Tue, 2 Jan 2024 03:51:35 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>, vegard.nossum@oracle.com
Cc: Vegard Nossum <vegard.nossum@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: add pyyaml to requirements.txt
Message-ID: <ZZP4x7oSbLdugeDL@gmail.com>
References: <20231222133628.3010641-1-vegard.nossum@oracle.com>
 <20231224164620.GB228041@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224164620.GB228041@kernel.org>

Hello Vegard,

On Fri, Dec 22, 2023 at 02:36:28PM +0100, Vegard Nossum wrote:
> Commit f061c9f7d058 ("Documentation: Document each netlink family") added
> a new Python script that is invoked during 'make htmldocs' and which reads
> the netlink YAML spec files.
> 
> Using the virtualenv from scripts/sphinx-pre-install, we get this new
> error wen running 'make htmldocs':

The commit doesn't depend on sphinx. This is a standalone script now.
The requirements file is at tools/net/ynl/requirements.txt not in sphinx

> Note: This was somehow present in the original patch submission:
> <https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/>
> I'm not sure why the pyyaml requirement disappeared in the meantime.

It disapperared because the original patch version was a sphinx module,
thus, pyaml was not at sphinx dependency.

In the commit final form, the script is a standalone script inside
'tools/net/ynl', and PyYAML is already tracked in
`tools/net/ynl/requirements.txt`.

That said, can you try to install `tools/net/ynl/requirements.txt` and
see if you are able to reproduce the problem?


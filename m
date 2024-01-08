Return-Path: <linux-kernel+bounces-19928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EFF8276E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FA41F212AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D65645B;
	Mon,  8 Jan 2024 17:59:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325AB55787;
	Mon,  8 Jan 2024 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28c0565df34so938605a91.0;
        Mon, 08 Jan 2024 09:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704736789; x=1705341589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddNmRgXTdaiclAr6P71lRtgB6j/qOy1G7OU9imrEHxc=;
        b=j3sES4rCOv0emeU8fRA1PKijbNy51Et9ltvObZj9RmdcY1HjZrzjIPSVtTS1aGxCdq
         5k72pXa0a4wPtdohn7wvkGg04z/8ZZcS1OxOCwIc6d6DWOFUVaa4mdIVoLanKOoda8xp
         m8EnCJPZv43DSo+3GXW3Adqvxm8zQswRqlibmExi51jnEs8PyUYxoBl2zgYL/wD4B5+y
         QE/SBmBJwF/OQJcZvO7iW/+I2sAHVIn6RP2PaYU2XH1kzvpqoNy7fUNGtK4VgDuOhpSK
         0rOlVf2hdCBh0EKR2CUBC6gZMdZ9Vqp/LsCLsMnHq7aWLH/arkXpAL2HpcvT4fmT34GH
         kmfg==
X-Gm-Message-State: AOJu0YxmrgWJjFAbp6Q8e18RbvQDSknnHIj8kteZMAYsDiLql0Mw3aR5
	yYuxiteKZbuObKFj3ROV0OQ=
X-Google-Smtp-Source: AGHT+IGWUEeatFIfgaL+0bNdjdfExTDZabWvGBKr5dpyJzoj40aqQIiEMFvILIT1oxrLBZ71gN7gig==
X-Received: by 2002:a17:90a:ba8a:b0:28d:293c:4cf6 with SMTP id t10-20020a17090aba8a00b0028d293c4cf6mr1389842pjr.92.1704736789260;
        Mon, 08 Jan 2024 09:59:49 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:cee:c48d:78d6:ed9a? ([2620:0:1000:8411:cee:c48d:78d6:ed9a])
        by smtp.gmail.com with ESMTPSA id li7-20020a17090b48c700b0028cec396567sm6853532pjb.44.2024.01.08.09.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:59:48 -0800 (PST)
Message-ID: <dd2ab246-04b5-4673-8e07-58bd751b5bac@acm.org>
Date: Mon, 8 Jan 2024 09:59:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: qedf: fix spelling typo in comment
Content-Language: en-US
To: zheng tan <tanzheng@kylinos.cn>, skashyap@marvell.com,
 jhasan@marvell.com, GR-QLogic-Storage-Upstream@marvell.com
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 k2ci <kernel-bot@kylinos.cn>
References: <20240102072735.973345-1-tanzheng@kylinos.cn>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240102072735.973345-1-tanzheng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/1/24 23:27, zheng tan wrote:
> -/* Indication whther its Target-auto-rsp mode or not */
> +/* Indication whether its Target-auto-rsp mode or not */
>   #define FCOE_RESPQE_TARGET_AUTO_RSP_MASK  0xFF
>   #define FCOE_RESPQE_TARGET_AUTO_RSP_SHIFT 24
>   };

Shouldn't "its" be changed into "it's"?

Thanks,

Bart.


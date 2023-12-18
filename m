Return-Path: <linux-kernel+bounces-2922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3181644F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22A41F21B35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFE62581;
	Mon, 18 Dec 2023 02:25:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mfwd14.mailplug.co.kr (mfwd14.mailplug.co.kr [14.63.174.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82723BE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wewakecorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wewakecorp.com
Received: (qmail 17255 invoked from network); 18 Dec 2023 11:18:45 +0900
X-Spam-Level: *
X-Spam-Virus: No
X-Spam-Pyzor: 
X-Spam-DCC:  : 
Received: from m41.mailplug.com (121.156.118.41)
	by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
	18 Dec 2023 11:18:41 +0900
Received: (qmail 769912 invoked from network); 18 Dec 2023 11:18:41 +0900
Received: from unknown (HELO sslauth16) (lsahn@wewakecorp.com@211.253.39.90)
	by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
	18 Dec 2023 11:18:41 +0900
Message-ID: <af67e443-665e-484a-847d-42a8da5f8993@wewakecorp.com>
Date: Mon, 18 Dec 2023 11:18:41 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v39 42/42] Smack: Remove LSM_FLAG_EXCLUSIVE
Content-Language: ko
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, mic@digikod.net
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-43-casey@schaufler-ca.com>
From: Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <20231215221636.105680-43-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

2023-12-16 오전 7:50에 Casey Schaufler 이(가) 쓴 글:
> Smack no longer has any behaviors that require LSM_FLAG_EXCLUSIVE.

Nice working, thank you!

BR,
Leesoo Ahn


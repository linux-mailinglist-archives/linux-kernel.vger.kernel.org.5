Return-Path: <linux-kernel+bounces-2498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985CB815DEC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 09:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4EF283195
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4161874;
	Sun, 17 Dec 2023 08:01:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out187-19.us.a.mail.aliyun.com (out187-19.us.a.mail.aliyun.com [47.90.187.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90821525D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=henry.hj@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.Vm8uC5r_1702796376;
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.Vm8uC5r_1702796376)
          by smtp.aliyun-inc.com;
          Sun, 17 Dec 2023 14:59:37 +0800
From: "Henry Huang" <henry.hj@antgroup.com>
To: yuzhao@google.com
Cc:  <akpm@linux-foundation.org>,
  "Henry Huang" <henry.hj@antgroup.com>,
  "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
   <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
  "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
Date: Sun, 17 Dec 2023 14:59:31 +0800
Message-ID: <20231217065936.43880-1-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAOUHufaHWaBcbaK=hFb5BpUSOLK6PsLxqmTU4N7WGnpS5yp-vQ@mail.gmail.com>
References: <CAOUHufaHWaBcbaK=hFb5BpUSOLK6PsLxqmTU4N7WGnpS5yp-vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Dec 17, 2023 at 05:07 AM Yu Zhao <yuzhao@google.com> wrote:
> Let me check the state of those private patches and get back to you in
> a couple of days. Thanks!

Thanks very much!
Looking forward your patches.

-- 
2.43.0



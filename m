Return-Path: <linux-kernel+bounces-13334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF718203A9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 06:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE601C20F7D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 05:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A872569;
	Sat, 30 Dec 2023 05:10:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63F23A0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 05:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.29])
	by sina.com (172.16.235.24) with ESMTP
	id 658FA62600000563; Sat, 30 Dec 2023 13:10:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 40762245089445
X-SMAIL-UIID: B3083ACEBD3A4F119390136B3577EA8F-20231230-131001-1
From: Hillf Danton <hdanton@sina.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: some works in 2023
Date: Sat, 30 Dec 2023 13:09:48 +0800
Message-Id: <20231230050948.2277-1-hdanton@sina.com>
In-Reply-To: <20231011211846.1345-1-hdanton@sina.com>
References: <20230831115730.4806-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 2023 alone (continued 3)

123 Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in wait4 (4)
https://lore.kernel.org/lkml/00000000000047894c0607976da4@google.com/
124 Subject: Re: [syzbot] [net?] [wireless?] WARNING in ieee80211_bss_info_change_notify (2)
https://lore.kernel.org/lkml/0000000000001e19970607a4dd3e@google.com/
125 Subject: Re: [syzbot] [batman?] INFO: rcu detected stall in rtnl_newlink (3)
https://lore.kernel.org/lkml/0000000000006fd2680607b89773@google.com/
126 Subject: Re: [syzbot] [dri?] WARNING in drm_prime_fd_to_handle_ioctl
https://lore.kernel.org/lkml/000000000000e7568c0607bcd926@google.com/
127 Subject: Re: [syzbot] [usb?] UBSAN: array-index-out-of-bounds in usbhid_parse
https://lore.kernel.org/lkml/00000000000085dbb40607e7ab96@google.com/
128 Subject: Re: [syzbot] [bluetooth?] possible deadlock in hci_rfkill_set_block
https://lore.kernel.org/lkml/000000000000aefcc8060874b51e@google.com/
129 Subject: Re: [syzbot] [net?] BUG: corrupted list in ptp_open
https://lore.kernel.org/lkml/000000000000dc201f0608c580ed@google.com/
130 Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iommufd_vfio_ioas
https://lore.kernel.org/lkml/0000000000006e530806093e7487@google.com/


131 Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_release
https://lore.kernel.org/lkml/000000000000bdaf5c06093e8951@google.com/
132 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in hci_conn_drop (2)
https://lore.kernel.org/lkml/000000000000a4069f06093ed844@google.com/
133 Subject: Re: [syzbot] [usb?] INFO: task hung in hub_port_init (3)
https://lore.kernel.org/lkml/0000000000004ad0220609530fc8@google.com/
134 Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
https://lore.kernel.org/lkml/000000000000823e060609cb53f4@google.com/
135 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
https://lore.kernel.org/lkml/00000000000081b046060a63b57f@google.com/
136 Subject: Re: [syzbot] [crypto?] INFO: task hung in hwrng_fillfn
https://lore.kernel.org/lkml/000000000000cf6dd1060b04d2d3@google.com/
137 Subject: Re: [syzbot] [net?] possible deadlock in sch_direct_xmit (2)
https://lore.kernel.org/lkml/000000000000c0a9df060b05b763@google.com/
138 Subject: Re: [syzbot] [block?] general protection fault in bio_first_folio
https://lore.kernel.org/lkml/000000000000fc92ae060c9c0e8b@google.com/
139 Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in taprio_dump
https://lore.kernel.org/lkml/0000000000004ae62a060cfe00ad@google.com/
140 Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in advance_sched
https://lore.kernel.org/lkml/000000000000a7f58a060d17a2cf@google.com/


141 Subject: Re: [syzbot] [bluetooth?] WARNING in l2cap_do_send (2)
https://lore.kernel.org/lkml/000000000000c7cd53060d90a0d8@google.com/
142 Subject: Re: [syzbot] [dri?] WARNING in drm_prime_destroy_file_private (2)
https://lore.kernel.org/lkml/0000000000002a80e9060db12a11@google.com/
143 Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel paging request in mmu_notifier_invalidate_range_start
https://lore.kernel.org/lkml/00000000000062705c060db09e22@google.com/
144 Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iommufd_ioas_iova_ranges
https://lore.kernel.org/all/20231027125413.2151-1-hdanton@sina.com/


continued 2
https://lore.kernel.org/all/20231011211846.1345-1-hdanton@sina.com/
continued 1
https://lore.kernel.org/all/20230831115730.4806-1-hdanton@sina.com/
continued 0
https://lore.kernel.org/all/20230731111444.1513-1-hdanton@sina.com/



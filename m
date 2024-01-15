Return-Path: <linux-kernel+bounces-25580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A42E82D2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30E81C2092F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFA815C4;
	Mon, 15 Jan 2024 01:30:07 +0000 (UTC)
Received: from cstnet.cn (smtp86.cstnet.cn [159.226.251.86])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11E1396;
	Mon, 15 Jan 2024 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [111.199.65.109] ) by
 ajax-webmail-APP-16 (Coremail) ; Mon, 15 Jan 2024 09:24:22 +0800
 (GMT+08:00)
Date: Mon, 15 Jan 2024 09:24:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: "Kees Cook" <keescook@chromium.org>
Cc: gregkh@linuxfoundation.org, gpiccoli@igalia.com, 
	john.ogness@linutronix.de, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pmladek@suse.com, rostedt@goodmis.org, 
	senozhatsky@chromium.org, tony.luck@intel.com
Subject: Re: [PATCH] cap_syslog: remove CAP_SYS_ADMIN when dmesg_restrict
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230921(8ad33efc)
 Copyright (c) 2002-2024 www.mailtech.cn cnic.cn
In-Reply-To: <202401080956.7FBE02F54C@keescook>
References: <2024010306-tweezers-skinhead-083e@gregkh>
 <20240105062007.26965-1-mengjingzi@iie.ac.cn>
 <202401080956.7FBE02F54C@keescook>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4660f3ea.625f.18d0ab83c58.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:sQCowAA3f4tGiaRlDdYGAA--.12749W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiDAcRE2Wj9+fUSAAAsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SSB0ZXN0ZWQgb24gdWJ1bnR1IDIyLjA0LjMgTFRTIGtlcm5lbCA2LjIuMTYgYW5kIEZlZG9yYSAz
OSBrZXJuZWwgNi42LjExLAp0aGUgd2FybmluZyBpcyBnb25lLCBhbmQgQ0FQX1NZU19BRE1JTiBp
cyBubyBsb25nZXIgYXV0aG9yaXplZCB0byBieXBhc3MgCmNoZWNrX3N5c2xvZ19wZXJtaXNzaW9u
cygpLgoKQmVzdCByZWdhcmRzLApKaW5nemkK


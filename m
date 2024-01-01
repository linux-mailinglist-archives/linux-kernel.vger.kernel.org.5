Return-Path: <linux-kernel+bounces-13938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2024F82151C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 20:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9555281B9F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 19:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C389CD529;
	Mon,  1 Jan 2024 19:07:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mta.juntadeandalucia.es (mta6.juntadeandalucia.es [217.12.26.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A2D51C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=juntadeandalucia.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juntadeandalucia.es
Received: from [10.240.225.252] (helo=mail.juntadeandalucia.es)
	by ccodis04.juntadeandalucia.es with esmtp (Exim 4.94.2)
	(envelope-from <luis.munoz.edu@juntadeandalucia.es>)
	id 1rKNda-000DT8-P4
	for linux-kernel@vger.kernel.org; Mon, 01 Jan 2024 20:07:46 +0100
Received: from [213.194.128.62] (helo=[192.168.1.148])
	by mail.juntadeandalucia.es with esmtpa (Exim 4.94.2)
	(envelope-from <luis.munoz.edu@juntadeandalucia.es>)
	id 1rKNda-0001w3-EU
	for linux-kernel@vger.kernel.org; Mon, 01 Jan 2024 20:07:46 +0100
Message-ID: <002cc4da-e502-4c79-97bd-0a8b6cb2630c@juntadeandalucia.es>
Date: Mon, 1 Jan 2024 20:07:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
Content-Language: es-ES
From: =?UTF-8?Q?Luis_Mu=C3=B1oz_Fuente?= <luis.munoz.edu@juntadeandalucia.es>
Subject: I can't activate term(e) and kill(i) magic SysRq key
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 182447 [Dec 31 2023]
X-KLMS-AntiSpam-Version: 6.1.0.3
X-KLMS-AntiSpam-Envelope-From: luis.munoz.edu@juntadeandalucia.es
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 213.194.128.62
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2024/01/01 17:34:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/01/01 17:15:00 #22921685
X-KLMS-AntiVirus-Status: Clean, skipped


Hello:
I try to activate all magic SysRq key options according to:
https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html
but I can't activate term(e) and kill(i) option, is this option
disabled? Thank you



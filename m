Return-Path: <linux-kernel+bounces-27014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AD482E928
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5291C22B58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C48826;
	Tue, 16 Jan 2024 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="kNV2pd59"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5D848D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 05:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References
	:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zDruBf/587kh1z8QNqXmvRK3zqoCr8aZ2zq86pCMqdk=; b=kNV2pd59s2fG/FjFdoPcncgmKO
	ngr0DPUuBP7pwef4DkgtkmATyW9w3prs0Kxp+68w+AHO9yRsWJhdT49e0ZqsXD4ZETcjbux/zD9sW
	33MXnJzgv1qMYx4CAkOa0R5C239XRP8fCJIE6Wm5oIiZmYbT1eG4XaZ4ZwEkGEUilhqM2oehwxkx7
	eyeMXZ8LAq/aVgcDN8cFNKFTIt7dJjgxFA8hvYcUdQFF7+uSjrPH1A9m0PA03K3RJrikPk5xOAStW
	FZKoR6jIrRix7gbRlng+kSEcI5RbxmRr0QzmZdHHRGf0gdU30AKV8WYlRa4h1GzzHO5Mwk7DMfeil
	fBFucDpA==;
Received: from [84.215.119.50] (port=60830 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rPbr6-00EM6N-I0
	for linux-kernel@vger.kernel.org;
	Tue, 16 Jan 2024 06:19:20 +0100
Message-ID: <230221f4-5095-4314-9c3f-fb338dab1cee@cu-phil.org>
Date: Tue, 16 Jan 2024 06:19:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Hux (was Fair Source)
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
To: linux-kernel@vger.kernel.org
References: <8064926b-ec75-4a64-9bbc-ac434c1e69ca@cu-phil.org>
 <0113f981-214e-4133-be55-614e34fce12b@cu-phil.org>
 <cf7cea10-fbe5-4649-9be1-ad1c68c1888d@cu-phil.org>
In-Reply-To: <cf7cea10-fbe5-4649-9be1-ad1c68c1888d@cu-phil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I updated the design concept to Hux. Deprecating "hacker", which has 
gotten negative associations.

Else everything as before.

-Peace.
Ywe Cærlyn

